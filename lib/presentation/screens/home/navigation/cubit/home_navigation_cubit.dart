import 'package:equatable/equatable.dart';
import 'package:praca_inz/presentation/common/navigation/navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/home/home_screen_page_type.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends NavigationCubit<HomeNavigationState> {
  HomeNavigationCubit() : super(initialState: HomeCprSession());

  void onSelectedPageTypeChanged(HomeScreenPageType selectedPageType) {
    switch (selectedPageType) {
      case HomeScreenPageType.cprSession:
        emit(HomeCprSession());
        break;
      case HomeScreenPageType.profile:
        emit(HomeProfile());
        break;
    }
  }
}
