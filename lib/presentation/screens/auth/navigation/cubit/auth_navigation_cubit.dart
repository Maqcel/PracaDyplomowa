import 'package:equatable/equatable.dart';
import 'package:praca_inz/presentation/common/navigation/navigation_cubit.dart';
import 'package:praca_inz/routing/app_routes.dart';

part 'auth_navigation_state.dart';

class AuthNavigationCubit extends NavigationCubit<AuthNavigationState> {
  AuthNavigationCubit() : super(initialState: AuthNavigationLogin());

  @override
  void onRoutePop(String? routeName) {
    if (routeName == AppRoutes.signup.name) {
      emit(AuthNavigationLogin());
    } else {
      onUnknownRouteName(routeName);
    }
  }

  void loginToSignup() => emit(AuthNavigationSignup());

  void signupToLogin() => emit(AuthNavigationLogin());
}
