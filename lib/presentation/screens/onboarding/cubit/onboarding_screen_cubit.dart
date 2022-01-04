import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/communication/network/dto/onboarding/onboarding_completed_request_dto.dart';
import 'package:praca_inz/domain/repositories/onboarding_repository.dart';

part 'onboarding_screen_state.dart';

class OnboardingScreenCubit extends Cubit<OnboardingScreenState> {
  final OnboardingRepository _onboardingRepository;
  OnboardingScreenCubit({required OnboardingRepository onboardingRepository})
      : _onboardingRepository = onboardingRepository,
        super(const OnboardingInitial());

  void initOnboarding() => emit(const OnboardingStatus(
        onboardingCompleted: false,
        firstName: '',
        lastName: '',
        groupId: '',
      ));

  Future<void> finishOnboarding(OnboardingStatus state) async {
    _onboardingRepository.completeOnboarding(OnboardingCompletedRequestDTO(
      firstName: state.firstName,
      lastName: state.lastName,
      groupId: state.groupId,
    ));
    emit(const OnboardingInProgress());
  }
}
