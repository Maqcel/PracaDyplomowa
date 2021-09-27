part of 'auth_navigation_cubit.dart';

abstract class AuthNavigationState extends Equatable {
  const AuthNavigationState();

  @override
  List<Object> get props => [];
}

class AuthNavigationLogin extends AuthNavigationState {}

class AuthNavigationSignup extends AuthNavigationState {}
