import 'package:flutter/material.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cubit/cpr_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/home/cpr/widgets/cpr_info.dart';
import 'package:praca_inz/presentation/screens/home/cpr/widgets/cpr_session.dart';
import 'package:praca_inz/presentation/screens/home/cpr/widgets/cpr_session_countdown.dart';

class CprLayoutProvider {
  static Widget renderCurrentLayout(
    CprScreenState state,
    Function() onStartSessionClicked,
    Function() onSubmitSessionClicked,
  ) {
    if (state is CprInformation) {
      return CprInfo(onCprSessionStart: onStartSessionClicked);
    } else if (state is CprSessionWaiting) {
      return const CprSessionCountdown();
    } else {
      return CprSession(onSubmitSessionClicked: onSubmitSessionClicked);
    }
  }
}
