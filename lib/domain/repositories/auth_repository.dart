import 'package:firebase_auth/firebase_auth.dart';
import 'package:praca_inz/communication/persistence/persistent_storage.dart';

class AuthRepository {
  final PersistentStorage _persistentStorage;

  AuthRepository({required PersistentStorage persistentStorage})
      : _persistentStorage = persistentStorage;

  bool hasValidUserSession() =>
      FirebaseAuth.instance.currentUser == null ? false : true;

  String getCurrentUserUid() => FirebaseAuth.instance.currentUser!.uid;

  Future<void> clearLocalUserSession() async {
    await FirebaseAuth.instance.signOut();
    await _persistentStorage.clearCprStatus();
  }
}
