import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/common/generic_call.dart';
import 'package:praca_inz/domain/failures/authorization_failure.dart';

class UserRepository {
  Future<Either<Failure, UserCredential>> login({
    required String email,
    required String password,
  }) async =>
      genericCall<UserCredential>(
        functionWithReturn: () =>
            FirebaseAuth.instance.signInWithEmailAndPassword(
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
        functionWithReturn: () =>
            FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
        failure: const AuthorizationFailure(
            message: 'Signup unsuccessful, try again!'),
      );

  Future<void> logout() async => await FirebaseAuth.instance.signOut();
}
