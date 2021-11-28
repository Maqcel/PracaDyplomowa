import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cubit/cpr_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';

class CprScreen extends StatefulWidget {
  const CprScreen({Key? key}) : super(key: key);

  @override
  _CprScreenState createState() => _CprScreenState();
}

class _CprScreenState extends State<CprScreen> {
  /// This callback needs to be stored due to the fact that
  /// We can't access [context.read] inside dispose
  late final Function() _disposeCallback;

  @override
  void initState() {
    super.initState();
    context.read<CprScreenCubit>().onScreenOpened();
    _disposeCallback = context.read<CprScreenCubit>().onScreenClosed;

    /// Testing period
    Timer(
      const Duration(minutes: 1),
      () => context.read<CprScreenCubit>().onCprSessionEnd(),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MainNavigationCubit, MainNavigationState>(
          listener: (context, state) => _onMainNavigationStateChanged(state),
          child: BlocConsumer<CprScreenCubit, CprScreenState>(
            buildWhen: (previous, current) => _buildWhen(previous, current),
            builder: (context, state) => _body(state),
            listener: (context, state) => _onStateChanged(state),
          ));

  // TODO: Implement action on change in MainNavigation if needed
  void _onMainNavigationStateChanged(MainNavigationState state) {}

  bool _buildWhen(CprScreenState previous, CprScreenState current) =>
      (current is CprInitial);

  Widget _body(CprScreenState state) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.read<CprScreenCubit>().printRaw(),
            child: const Text('PRINT RAW DATA'),
          ),
        ),
      );

  // TODO: Implement actions on change in local state
  void _onStateChanged(CprScreenState state) {}

  @override
  void dispose() {
    _disposeCallback();
    super.dispose();
  }
}
