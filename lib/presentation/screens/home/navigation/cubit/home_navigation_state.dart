part of 'home_navigation_cubit.dart';

abstract class HomeNavigationState extends Equatable {
  const HomeNavigationState();

  @override
  List<Object> get props => [];
}

class HomeCprSession extends HomeNavigationState {}

class HomeProfile extends HomeNavigationState {}

class HomeDevelopment extends HomeNavigationState {}
