import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
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
    _initApi();
  }

  static void _initAnalytics() =>
      _getIt.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics());

  //TODO: Implement firestore
  static void _initApi() {}

  static T get<T extends Object>() => _getIt.get<T>();
}