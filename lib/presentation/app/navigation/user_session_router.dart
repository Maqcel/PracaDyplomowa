import 'package:flutter/material.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:praca_inz/presentation/common/navigation/cubit_router.dart';
import 'package:praca_inz/presentation/page_transitions/slide_transition_page.dart';
import 'package:praca_inz/presentation/screens/auth/auth_screen.dart';
import 'package:praca_inz/presentation/screens/main/main_screen.dart';
import 'package:praca_inz/presentation/screens/splash/splash_screen.dart';
import 'package:praca_inz/routing/app_routes.dart';

/// Router on top of the Widget Tree
class UserSessionRouter extends CubitRouter<UserSessionNavigationCubit,
    UserSessionNavigationState, void> {
  @override
  GlobalKey<NavigatorState> internalNavigationKey =
      GlobalKey(debugLabel: 'UserSessionRouterKey');

  @override
  List<Page> getPageStack(
      BuildContext context, UserSessionNavigationState state) {
    List<Page> pageStack = [];

    if (state is UserSessionNavigationInitial) {
      pageStack.add(
        SlideTransitionPage<void>(
          name: AppRoutes.splash.name,
          key: AppRoutes.splash.valueKey,
          child: const SplashScreen(),
        ),
      );
    }

    if (state is UserSessionNavigationLoggedIn) {
      pageStack.add(
        SlideTransitionPage<void>(
          name: AppRoutes.home.name,
          key: AppRoutes.home.valueKey,
          child: const MainScreen(),
        ),
      );
    }

    if (state is UserSessionNavigationLoggedOut) {
      pageStack.add(
        SlideTransitionPage<void>(
          name: AppRoutes.login.name,
          key: AppRoutes.login.valueKey,
          child: const AuthScreen(),
        ),
      );
    }

    return pageStack;
  }
}
