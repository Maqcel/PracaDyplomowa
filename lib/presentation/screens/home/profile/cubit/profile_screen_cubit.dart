import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/models/user_profile.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';
import 'package:praca_inz/domain/repositories/user_repository.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  ProfileScreenCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(ProfileLoading());

  Future<void> onScreenOpened() async => emit(ProfileLoaded(
        userProfile: await _userRepository
            .getUserProfile(_authRepository.getCurrentUserUid()),
      ));

  Future<void> onLogoutClicked() async {
    await _authRepository.clearLocalUserSession();
    emit(ProfileLoggedOut());
  }
}
