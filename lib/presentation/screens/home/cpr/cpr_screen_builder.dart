import 'package:flutter/material.dart';
import 'package:praca_inz/domain/models/session_result.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cpr_layout_provider.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cubit/cpr_screen_cubit.dart';

class CprScreenBuilder {
  static Widget build({
    required BuildContext context,
    required CprScreenState state,
    required Function() onStartSessionClicked,
    required Function(SessionResult) onSubmitSessionClicked,
  }) =>
      CprLayoutProvider.renderCurrentLayout(
        state,
        onStartSessionClicked,
        onSubmitSessionClicked,
      );
}
