import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praca_inz/communication/network/dto/onboarding/onboarding_completed_request_dto.dart';
import 'package:praca_inz/config/paths.dart';

class OnboardingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<List<String>> fetchListOfGroups() async =>
      (await _firestore.collection(Paths.groupsPath).get())
          .docs
          .map((doc) => doc.id)
          .toList();

  Future<void> completeOnboarding(
          OnboardingCompletedRequestDTO onboardingData) async =>
      await _firestore
          .collection(Paths.usersPath)
          .doc(_firebaseAuth.currentUser!.uid)
          .update(onboardingData.toJson());
}
