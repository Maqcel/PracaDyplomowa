import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/onboarding/cubit/onboarding_screen_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingScreenCubit>().initOnboarding();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<OnboardingScreenCubit, OnboardingScreenState>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  bool _buildWhen(
    OnboardingScreenState previous,
    OnboardingScreenState current,
  ) =>
      (current is OnboardingInProgress || current is OnboardingStatus);

  // TODO: Implement onboarding body
  Widget _body(OnboardingScreenState state) => state is OnboardingStatus
      ? Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(),
        )
      : const CircularProgressIndicator();

  void _onStateChanged(OnboardingScreenState state) {
    if (state is OnboardingInProgress) {
      context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    }
  }
}
