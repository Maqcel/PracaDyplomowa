import 'package:flutter/material.dart';
import 'package:praca_inz/presentation/common/navigation/cubit_router.dart';
import 'package:praca_inz/presentation/page_transitions/slide_transition_page.dart';
import 'package:praca_inz/presentation/screens/home/home_screen.dart';
import 'package:praca_inz/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';
import 'package:praca_inz/routing/app_routes.dart';

/// This router handles navigation between [HomeScreen]
/// And all the pages displayed 'above' it as fullscreen popups
class MainRouter
    extends CubitRouter<MainNavigationCubit, MainNavigationState, void> {
  static final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'MainRouterKey');

  @override
  GlobalKey<NavigatorState> internalNavigationKey = key;

  @override
  List<Page> getPageStack(BuildContext context, MainNavigationState state) {
    List<Page> pageStack = [];

    pageStack.add(SlideTransitionPage.fromRoute(
      route: AppRoutes.home,
      child: const HomeScreen(),
    ));

    return pageStack;
  }
}
