part of 'home_navigation_cubit.dart';

abstract class HomeNavigationState extends Equatable {
  final bool cprSessionInProgress;
  const HomeNavigationState({required this.cprSessionInProgress});

  @override
  List<Object> get props => [cprSessionInProgress];
}

class HomeCprSession extends HomeNavigationState {
  const HomeCprSession({required bool cprSessionInProgress})
      : super(cprSessionInProgress: cprSessionInProgress);
}

class HomeProfile extends HomeNavigationState {
  const HomeProfile() : super(cprSessionInProgress: false);
}
