import 'package:equatable/equatable.dart';
import 'package:praca_inz/presentation/common/navigation/navigation_cubit.dart';
import 'package:praca_inz/routing/app_routes.dart';
import 'package:praca_inz/routing/route_definition.dart';

part 'main_navigation_state.dart';

class MainNavigationCubit extends NavigationCubit<MainNavigationState> {
  MainNavigationCubit()
      : super(initialState: MainNavigationHome(previousRoute: AppRoutes.home));

  @override
  void onRoutePop(String? routeName) {
    super.onRoutePop(routeName);
  }
}
