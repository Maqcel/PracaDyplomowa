import 'package:flutter/material.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/screens/home/home_screen_page.dart';
import 'package:praca_inz/presentation/screens/home/home_screen_page_type.dart';
import 'package:praca_inz/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';

class HomeScreenPageProvider {
  static List<HomeScreenPage> pages = [
    HomeScreenPage(index: 0, type: HomeScreenPageType.cprSession),
    HomeScreenPage(index: 1, type: HomeScreenPageType.profile),
  ];

  static int getIndexByState(HomeNavigationState state) =>
      getIndexByPageType(getPageTypeByState(state));

  static HomeScreenPageType getPageTypeByState(HomeNavigationState state) {
    if (state is HomeCprSession) {
      return HomeScreenPageType.cprSession;
    } else if (state is HomeProfile) {
      return HomeScreenPageType.profile;
    } else {
      throw ArgumentError('State $state couldn\'t be mapped to page type');
    }
  }

  static int getIndexByPageType(HomeScreenPageType type) =>
      pages.firstWhere((element) => element.type == type, orElse: () {
        throw ArgumentError('Unsupported Home Screen page type: $type');
      }).index;

  static HomeScreenPageType getPageTypeByIndex(int index) =>
      pages.firstWhere((element) => element.index == index, orElse: () {
        throw IndexError(index, pages);
      }).type;

  static List<BottomNavigationBarItem> getBottomNavBarItems(
          BuildContext context) =>
      pages.map((page) => getBottomNavBarItem(context, page.type)).toList();

  static BottomNavigationBarItem getBottomNavBarItem(
      BuildContext context, HomeScreenPageType type) {
    Color? activeIconColor =
        context.theme.bottomNavigationBarTheme.selectedLabelStyle?.color;
    Color? idleIconColor =
        context.theme.bottomNavigationBarTheme.unselectedLabelStyle?.color;
    Color? backgroundColor =
        context.theme.bottomNavigationBarTheme.backgroundColor;

    switch (type) {
      case HomeScreenPageType.cprSession:
        return BottomNavigationBarItem(
          backgroundColor: backgroundColor,
          label: context.localizations.mainBottomNavCprSessionLabel,
          icon: Icon(
            Icons.medical_services_rounded,
            color: idleIconColor,
          ),
          activeIcon: Icon(
            Icons.medical_services_rounded,
            color: activeIconColor,
          ),
        );
      case HomeScreenPageType.profile:
        return BottomNavigationBarItem(
          backgroundColor: backgroundColor,
          label: context.localizations.mainBottomNavProfileLabel,
          icon: Icon(
            Icons.people_alt_outlined,
            color: idleIconColor,
          ),
          activeIcon: Icon(
            Icons.people_alt_outlined,
            color: activeIconColor,
          ),
        );
      default:
        throw ArgumentError('Unsupported Home Screen page type: $type');
    }
  }
}
