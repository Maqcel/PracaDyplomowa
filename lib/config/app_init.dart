import 'package:firebase_core/firebase_core.dart';

class AppInit {
  static Future<void> initApp() async {
    await _initFirebase();
  }

  static Future<void> _initFirebase() async => await Firebase.initializeApp();
}
