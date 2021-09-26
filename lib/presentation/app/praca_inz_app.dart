import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/config/app_init.dart';
import 'package:praca_inz/config/localization/localization_config.dart';
import 'package:praca_inz/di/app_bloc_providers.dart';
import 'package:praca_inz/di/app_repository_providers.dart';
import 'package:praca_inz/di/service_locator.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/app/navigation/user_session_router.dart';

class PracaInzApp extends StatelessWidget {
  final bool _shouldShowDebug;
  const PracaInzApp({Key? key, bool? shouldShowDebug})
      : _shouldShowDebug = shouldShowDebug ?? true,
        super(key: key);

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
        debugShowCheckedModeBanner: _shouldShowDebug,
        supportedLocales: LocalizationConfig.supportedLocalizations,
        localizationsDelegates: LocalizationConfig.localizationDelegate,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: ServiceLocator.get<FirebaseAnalytics>(),
          ),
        ],
        home: MultiRepositoryProvider(
          providers: AppRepositoryProviders().providers,
          child: MultiBlocProvider(
            providers: AppBlocProviders().providers,
            child: Router(
              routerDelegate: UserSessionRouter(),
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          ),
        ),
      );
}
