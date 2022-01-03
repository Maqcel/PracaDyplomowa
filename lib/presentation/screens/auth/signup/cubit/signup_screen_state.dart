part of 'signup_screen_cubit.dart';

abstract class SignupScreenState extends Equatable {
  final bool allowSignup;

  const SignupScreenState({required this.allowSignup});

  @override
  List<Object> get props => [allowSignup];
}

class SignupScreenInitial extends SignupScreenState {
  const SignupScreenInitial() : super(allowSignup: false);
}

class SignupDataChanged extends SignupScreenState {
  const SignupDataChanged({required bool allowSignup})
      : super(allowSignup: allowSignup);
}

class SignupInProgress extends SignupScreenState {
  const SignupInProgress() : super(allowSignup: false);
}

class SignupSuccess extends SignupScreenState {
  const SignupSuccess() : super(allowSignup: false);
}

class SignupError extends SignupScreenState {
  final Failure failure;

  const SignupError({required this.failure}) : super(allowSignup: true);

  @override
  List<Object> get props => [failure];
}
