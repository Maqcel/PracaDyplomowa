import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/models/user_profile.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final AuthRepository _authRepository;
  ProfileScreenCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(ProfileLoading());

  void onScreenOpened() => {
        emit(const ProfileLoaded(
          userProfile: UserProfile(
            uid: '',
            completedSessions: [],
            firstName: '',
            groupId: '',
            lastName: '',
          ),
        ))
      };

  void onLogoutClicked() {
    _authRepository.clearLocalUserSession();
    emit(ProfileLoggedOut());
  }
}
