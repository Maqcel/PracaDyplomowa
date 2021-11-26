import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:praca_inz/di/service_locator.dart';

class AppInit {
  static Future<void> initApp() async {
    await _initFirebase();
    _initSensors();
  }

  static Future<void> _initFirebase() async => await Firebase.initializeApp();

  static void _initSensors() {
    ServiceLocator.get<AccelerometerSensorService>()
        .initAccelerometerSensorStream();
    ServiceLocator.get<GyroscopeSensorService>().initGyroscopeSensorStream();
    log('Sensors: Initialized');
  }
}
