import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  bool hasValidUserSession() =>
      FirebaseAuth.instance.currentUser == null ? false : true;

  void clearLocalUserSession() => FirebaseAuth.instance.signOut();
}
