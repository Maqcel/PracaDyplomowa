import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:praca_inz/config/app_init.dart';
import 'package:praca_inz/config/localization/localization_config.dart';
import 'package:praca_inz/di/service_locator.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class PracaInzApp extends StatelessWidget {
  const PracaInzApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: AppInit.initApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(
              context.localizations.appInitError,
              error: snapshot.error,
              stackTrace: snapshot.stackTrace,
            );
          }
          return _app();
        },
      );

  Widget _app() => MaterialApp(
        supportedLocales: LocalizationConfig.supportedLocalizations,
        localizationsDelegates: LocalizationConfig.localizationDelegate,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: ServiceLocator.get<FirebaseAnalytics>(),
          ),
        ],
        home: const Scaffold(
          backgroundColor: Colors.red,
          body: TestWidget(),
        ),
      );
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          context.localizations.helloWorld,
        ),
      );
}
