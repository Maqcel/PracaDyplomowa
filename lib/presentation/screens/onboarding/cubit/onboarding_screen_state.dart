part of 'onboarding_screen_cubit.dart';

abstract class OnboardingScreenState extends Equatable {
  final bool onboardingCompleted;

  const OnboardingScreenState({required this.onboardingCompleted});

  @override
  List<Object?> get props => [onboardingCompleted];
}

class OnboardingLoading extends OnboardingScreenState {
  const OnboardingLoading() : super(onboardingCompleted: false);
}

class OnboardingStatus extends OnboardingScreenState {
  final List<String> listOfGroups;
  final String firstName;
  final String lastName;
  final String groupId;

  const OnboardingStatus({
    required this.listOfGroups,
    required bool onboardingCompleted,
    required this.firstName,
    required this.lastName,
    required this.groupId,
  }) : super(onboardingCompleted: onboardingCompleted);

  OnboardingStatus copyWith({
    List<String>? listOfGroups,
    bool? onboardingCompleted,
    String? firstName,
    String? lastName,
    String? groupId,
  }) =>
      OnboardingStatus(
        listOfGroups: listOfGroups ?? this.listOfGroups,
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        groupId: groupId ?? this.groupId,
      );

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        groupId,
      ];
}

class OnboardingInProgress extends OnboardingScreenState {
  const OnboardingInProgress() : super(onboardingCompleted: false);
}
