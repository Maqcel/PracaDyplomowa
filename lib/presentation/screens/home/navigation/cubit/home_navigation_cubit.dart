import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:praca_inz/presentation/common/navigation/navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/home/home_screen_page_type.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends NavigationCubit<HomeNavigationState> {
  HomeNavigationCubit()
      : super(
          initialState: const HomeCprSession(cprSessionInProgress: false),
        );

  void onSelectedPageTypeChanged(HomeScreenPageType selectedPageType) {
    switch (selectedPageType) {
      case HomeScreenPageType.cprSession:
        emit(const HomeCprSession(cprSessionInProgress: false));
        break;
      case HomeScreenPageType.profile:
        emit(const HomeProfile());
        break;
    }
  }

  void onCprSessionStart() => emit(const HomeCprSession(
        cprSessionInProgress: true,
      ));

  void onCprSessionStop() => emit(const HomeCprSession(
        cprSessionInProgress: false,
      ));
}
