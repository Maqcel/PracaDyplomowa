import 'package:flutter/material.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/screens/main/navigation/main_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainRouter _routerDelegate = MainRouter();
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
  Widget build(BuildContext context) => Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      );
}
