import 'package:flutter/material.dart';
import 'package:praca_inz/gen/app_localizations.dart';

extension ContextProvider on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
  Router get router => Router.of(this);
  NavigatorState get navigator => Navigator.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);
}
