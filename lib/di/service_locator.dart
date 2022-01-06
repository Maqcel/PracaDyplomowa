import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:praca_inz/communication/persistence/persistent_storage.dart';
import 'package:praca_inz/communication/persistence/shared_preferences_persistent_storage.dart';
import 'package:praca_inz/communication/sensors/accelerometer_sensor.dart';
import 'package:praca_inz/communication/sensors/gyroscope_sensor.dart';
import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:praca_inz/config/build_environment.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static void initDevelopment() {
    _getIt.registerSingleton(DevelopmentEnvironment());
    _init(BuildType.development);
  }

  static void initProduction() {
    _getIt.registerSingleton(ProductionEnvironment());
    _init(BuildType.production);
  }

  static void _init(BuildType currentBuild) {
    log(currentBuild.toString());
    _initAnalytics();
    _initSensors();
    _initSharedPreferences();
  }

  static void _initAnalytics() =>
      _getIt.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics());

  static void _initSensors() {
    _getIt.registerLazySingleton<AccelerometerSensorService>(
        () => AccelerometerSensor());
    _getIt
        .registerLazySingleton<GyroscopeSensorService>(() => GyroscopeSensor());
  }

  static void _initSharedPreferences() =>
      _getIt.registerSingleton<PersistentStorage>(
          SharedPreferencesPersistentStorage());

  static T get<T extends Object>() => _getIt.get<T>();
}
