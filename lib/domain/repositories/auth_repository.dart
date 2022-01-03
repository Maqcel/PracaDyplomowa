import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  bool hasValidUserSession() =>
      FirebaseAuth.instance.currentUser == null ? false : true;

  Future<void> clearLocalUserSession() async =>
      await FirebaseAuth.instance.signOut();
}
