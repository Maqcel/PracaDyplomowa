import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/config/dimensions/animation_dimension.dart';
import 'package:praca_inz/domain/models/session_result.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/dialogs/confirmation_dialog.dart';
import 'package:praca_inz/presentation/dialogs/cpr_instruction_dialog.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cpr_screen_builder.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cubit/cpr_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';

class CprScreen extends StatefulWidget {
  const CprScreen({Key? key}) : super(key: key);

  @override
  _CprScreenState createState() => _CprScreenState();
}

class _CprScreenState extends State<CprScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CprScreenCubit>().onScreenOpened();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<HomeNavigationCubit, HomeNavigationState>(
        listener: (context, state) => _onHomeNavigationStateChanged(state),
        child: BlocConsumer<CprScreenCubit, CprScreenState>(
          buildWhen: (previous, current) => _buildWhen(previous, current),
          builder: (context, state) => _body(state),
          listener: (context, state) => _onStateChanged(state),
        ),
      );

  void _onHomeNavigationStateChanged(HomeNavigationState state) => state
          is HomeCprSession
      ? state.cprSessionInProgress
          ? context.read<CprScreenCubit>().onCprSessionStart()
          : context.read<CprScreenCubit>().onCprSessionSubmittedOrDiscarded()
      : null;

  bool _buildWhen(CprScreenState previous, CprScreenState current) =>
      (current is CprInitial ||
          current is CprInformation ||
          current is CprSessionWaiting ||
          current is CprSessionProgress ||
          current is CprSessionSubmit);

  Widget _body(CprScreenState state) => Scaffold(
        body: AnimatedSwitcher(
          duration: AnimDimension.durationShort,
          child: _content(state),
        ),
      );

  Widget _content(CprScreenState state) {
    if (state is! CprInitial) {
      return _cprScreen(state);
    } else {
      return _loadingIndicator();
    }
  }

  Widget _cprScreen(CprScreenState state) => CprScreenBuilder.build(
        context: context,
        state: state,
        onStartSessionClicked: _onStartSessionClicked,
        onSubmitSessionClicked: _onSubmitSessionClicked,
      );

  void _onStartSessionClicked() =>
      context.read<HomeNavigationCubit>().onCprSessionStart();

  void _onSubmitSessionClicked(SessionResult sessionResult) =>
      _showConfirmSubmitDialog(sessionResult);

  Future<void> _showConfirmSubmitDialog(SessionResult sessionResult) async {
    bool? submitConfirmed = await showDialog<bool>(
        context: context,
        builder: (context) => ConfirmationDialog(
              titleText: context.localizations.cprSessionSessionSubmitTitle,
              bodyText: context.localizations.cprSessionSessionSubmitText,
              dismissText: context
                  .localizations.cprSessionSessionSubmitDismissButtonText,
              confirmText: context
                  .localizations.cprSessionSessionSubmitConfirmButtonText,
            ));

    if (submitConfirmed == true) {
      context.read<CprScreenCubit>().sessionSubmitRequest(sessionResult);
    }
    context.read<CprScreenCubit>().onCprSessionSubmittedOrDiscarded();
    context.read<HomeNavigationCubit>().onCprSessionStop();
  }

  Widget _loadingIndicator() => Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      );

  void _onStateChanged(CprScreenState state) {
    if (state is CprInformation && state.shouldShowCprInstruction) {
      _showCprInstructionDialog();
    }
  }

  Future<void> _showCprInstructionDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (context) => const CprInstructionDialog(),
    );
    context.read<CprScreenCubit>().onCprInstructionPop();
  }
}
