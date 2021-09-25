import 'package:flutter/material.dart';
import 'package:praca_inz/di/service_locator.dart';
import 'package:praca_inz/presentation/app/praca_inz_app.dart';

void main() {
  ServiceLocator.initProduction();
  runApp(const PracaInzApp());
}
