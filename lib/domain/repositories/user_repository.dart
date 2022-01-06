import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praca_inz/communication/network/dto/user/user_profile_dto.dart';
import 'package:praca_inz/config/paths.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/common/generic_call.dart';
import 'package:praca_inz/domain/failures/authorization_failure.dart';
import 'package:praca_inz/domain/models/user_profile.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Either<Failure, UserCredential>> login({
    required String email,
    required String password,
  }) async =>
      genericCall<UserCredential>(
        functionWithReturn: () => _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        failure: const AuthorizationFailure(
            message: 'Login unsuccessful, try again!'),
      );

  Future<Either<Failure, UserCredential>> signup({
    required String email,
    required String password,
  }) async =>
      genericCall<UserCredential>(
        functionWithReturn: () => _signUpAndCreateUser(
          email: email,
          password: password,
        ),
        failure: const AuthorizationFailure(
            message: 'Signup unsuccessful, try again!'),
      );

  Future<UserCredential> _signUpAndCreateUser({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    DocumentReference userReference =
        _firestore.collection(Paths.usersPath).doc(userCredential.user!.uid);

    await userReference.set(
      UserProfileDTO(
        uid: userCredential.user!.uid,
        completedSessions: [],
        firstName: '',
        groupId: '',
        lastName: '',
      ).toJson(),
    );

    return userCredential;
  }

  Future<UserProfile> getUserProfile(String userUid) async =>
      UserProfile.fromDTO(UserProfileDTO.fromJson(
        (await _firestore.collection(Paths.usersPath).doc(userUid).get())
            .data()!,
      ));
}
