import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:praca_inz/gen/app_localizations.dart';

class LocalizationConfig {
  static List<LocalizationsDelegate> localizationDelegate = const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static List<Locale> supportedLocalizations = const [
    Locale('en', ''),
  ];
}
