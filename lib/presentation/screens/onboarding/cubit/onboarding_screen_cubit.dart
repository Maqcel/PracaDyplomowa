import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/communication/network/dto/onboarding/onboarding_completed_request_dto.dart';
import 'package:praca_inz/domain/repositories/onboarding_repository.dart';

part 'onboarding_screen_state.dart';

class OnboardingScreenCubit extends Cubit<OnboardingScreenState> {
  final OnboardingRepository _onboardingRepository;
  OnboardingScreenCubit({required OnboardingRepository onboardingRepository})
      : _onboardingRepository = onboardingRepository,
        super(const OnboardingLoading());

  Future<void> initOnboarding() async => emit(OnboardingStatus(
        listOfGroups: await _onboardingRepository.fetchListOfGroups(),
        onboardingCompleted: false,
        firstName: '',
        lastName: '',
        groupId: '',
      ));

  void changeOnboardingPersonalData({
    required String name,
    required String surname,
    required String groupId,
  }) =>
      emit((state as OnboardingStatus).copyWith(
        onboardingCompleted:
            _checkIfAlreadyCompleted(state as OnboardingStatus) ||
                (name.isNotEmpty && surname.isNotEmpty && groupId.isNotEmpty),
        firstName: name,
        lastName: surname,
        groupId: groupId,
      ));

  bool _checkIfAlreadyCompleted(OnboardingStatus currentState) {
    if (currentState.firstName.isNotEmpty &&
        currentState.lastName.isNotEmpty &&
        currentState.groupId.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> finishOnboarding(OnboardingStatus state) async {
    _onboardingRepository.completeOnboarding(OnboardingCompletedRequestDTO(
      firstName: state.firstName,
      lastName: state.lastName,
      groupId: state.groupId,
    ));
    emit(const OnboardingInProgress());
  }
}
