part of 'login_screen_cubit.dart';

abstract class LoginScreenState extends Equatable {
  final bool allowLogin;

  const LoginScreenState({required this.allowLogin});

  @override
  List<Object> get props => [allowLogin];
}

class LoginScreenInitial extends LoginScreenState {
  const LoginScreenInitial() : super(allowLogin: false);
}

class LoginDataChanged extends LoginScreenState {
  const LoginDataChanged({required bool allowLogin})
      : super(allowLogin: allowLogin);
}

class LoginInProgress extends LoginScreenState {
  const LoginInProgress() : super(allowLogin: false);
}

class LoginSuccess extends LoginScreenState {
  const LoginSuccess() : super(allowLogin: false);
}

class LoginError extends LoginScreenState {
  final Failure failure;

  const LoginError({required this.failure}) : super(allowLogin: true);

  @override
  List<Object> get props => [failure];
}
