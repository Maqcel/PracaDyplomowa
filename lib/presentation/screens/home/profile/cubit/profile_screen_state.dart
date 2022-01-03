part of 'profile_screen_cubit.dart';

abstract class ProfileScreenState extends Equatable {
  const ProfileScreenState();

  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileScreenState {}

class ProfileLoaded extends ProfileScreenState {
  final UserProfile userProfile;

  const ProfileLoaded({required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

class ProfileLoadError extends ProfileScreenState {
  final Failure failure;

  const ProfileLoadError({
    required this.failure,
  }) : super();

  @override
  List<Object> get props => [failure];
}

class ProfileLoggedOut extends ProfileScreenState {}
