import 'package:flutter/material.dart';
import 'package:praca_inz/presentation/common/navigation/cubit_router.dart';
import 'package:praca_inz/presentation/page_transitions/fade_transition_page.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cpr_screen.dart';
import 'package:praca_inz/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';
import 'package:praca_inz/routing/app_routes.dart';

class HomeScreenRouter
    extends CubitRouter<HomeNavigationCubit, HomeNavigationState, void> {
  @override
  GlobalKey<NavigatorState> internalNavigationKey =
      GlobalKey(debugLabel: 'HomeRouterKey');

  @override
  List<Page> getPageStack(BuildContext context, HomeNavigationState state) {
    List<Page> pageStack = [];

    if (state is HomeCprSession) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.homeCprSession,
        child: const CprScreen(),
      ));
    }

    if (state is HomeProfile) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.homeProfile,
        child: const Scaffold(
          body: Center(child: Text('Profile')),
        ),
      ));
    }

    return pageStack;
  }

  @override
  Future<void> setNewRoutePath(void configuration) {
    throw UnimplementedError();
  }
}
