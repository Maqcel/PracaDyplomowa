import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/screens/home/home_screen_page_provider.dart';
import 'package:praca_inz/presentation/screens/home/home_screen_page_type.dart';
import 'package:praca_inz/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/home/navigation/home_screen_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenRouter _routerDelegate = HomeScreenRouter();
  ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    _initBackButtonDispatcher();
    super.didChangeDependencies();
  }

  void _initBackButtonDispatcher() {
    _backButtonDispatcher ??=
        ChildBackButtonDispatcher(context.router.backButtonDispatcher!);
    _backButtonDispatcher?.takePriority();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
        builder: (context, state) => _body(state),
      );

  Widget _body(HomeNavigationState state) => Scaffold(
        body: Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
        bottomNavigationBar:
            state.cprSessionInProgress ? null : _bottomNavigationBar(state),
      );

  BottomNavigationBar _bottomNavigationBar(HomeNavigationState state) =>
      BottomNavigationBar(
        items: HomeScreenPageProvider.getBottomNavBarItems(context),
        currentIndex: HomeScreenPageProvider.getIndexByState(state),
        onTap: (index) => _onSelectedPageIndexChanged(index),
        type: BottomNavigationBarType.fixed,
      );

  void _onSelectedPageIndexChanged(int newIndex) {
    HomeScreenPageType selectedPageType =
        HomeScreenPageProvider.getPageTypeByIndex(newIndex);

    context
        .read<HomeNavigationCubit>()
        .onSelectedPageTypeChanged(selectedPageType);
  }
}
