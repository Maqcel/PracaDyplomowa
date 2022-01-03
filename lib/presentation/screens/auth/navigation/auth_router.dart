import 'package:flutter/material.dart';
import 'package:praca_inz/presentation/common/navigation/cubit_router.dart';
import 'package:praca_inz/presentation/page_transitions/fade_transition_page.dart';
import 'package:praca_inz/presentation/screens/auth/login/login_screen.dart';
import 'package:praca_inz/presentation/screens/auth/navigation/cubit/auth_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/auth/signup/signup_screen.dart';
import 'package:praca_inz/routing/app_routes.dart';

class AuthRouter
    extends CubitRouter<AuthNavigationCubit, AuthNavigationState, void> {
  @override
  GlobalKey<NavigatorState> internalNavigationKey =
      GlobalKey(debugLabel: 'AuthRouterKey');

  @override
  List<Page> getPageStack(BuildContext context, AuthNavigationState state) {
    List<Page> pageStack = [];

    if (state is AuthNavigationLogin) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.login,
        child: const LoginScreen(),
      ));
    }

    if (state is AuthNavigationSignup) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.signup,
        child: const SignupScreen(),
      ));
    }

    return pageStack;
  }
}
