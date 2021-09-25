part of 'user_session_navigation_cubit.dart';

abstract class UserSessionNavigationState extends Equatable {
  const UserSessionNavigationState();

  @override
  List<Object> get props => [];
}

class UserSessionNavigationInitial extends UserSessionNavigationState {}

class UserSessionNavigationLoggedIn extends UserSessionNavigationState {}

class UserSessionNavigationLoggedOut extends UserSessionNavigationState {}
