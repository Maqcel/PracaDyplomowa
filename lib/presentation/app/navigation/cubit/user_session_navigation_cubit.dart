import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/config/paths.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';
import 'package:praca_inz/presentation/common/navigation/navigation_cubit.dart';

part 'user_session_navigation_state.dart';

class UserSessionNavigationCubit
    extends NavigationCubit<UserSessionNavigationState> {
  final AuthRepository _authRepository;

  UserSessionNavigationCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(
          initialState: UserSessionNavigationInitial(),
        );

  /// This navigation Cubit is on the top of the stack
  /// Route pop on this level closes the app
  @override
  void onRoutePop(String? routeName) {}

  Future<void> onUserSessionStateChanged() async =>
      _authRepository.hasValidUserSession()
          ? await checkUserDataStatus()
              ? emit(UserSessionNavigationLoggedIn())
              : emit(UserSessionNavigationOnboarding())
          : emit(UserSessionNavigationLoggedOut());

  Future<bool> checkUserDataStatus() async => (await FirebaseFirestore.instance
              .collection(Paths.usersPath)
              .doc(_authRepository.getCurrentUserUid())
              .get())
          .data()!['firstName']
          .toString()
          .isEmpty
      ? false
      : true;
}
