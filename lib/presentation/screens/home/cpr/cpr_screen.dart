import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cubit/cpr_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';

class CprScreen extends StatefulWidget {
  const CprScreen({Key? key}) : super(key: key);

  @override
  _CprScreenState createState() => _CprScreenState();
}

class _CprScreenState extends State<CprScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CprScreenCubit>().onScreenOpened();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<HomeNavigationCubit, HomeNavigationState>(
        listener: (context, state) => _onHomeNavigationStateChanged(state),
        child: BlocConsumer<CprScreenCubit, CprScreenState>(
          buildWhen: (previous, current) => _buildWhen(previous, current),
          builder: (context, state) => _body(state),
          listener: (context, state) => _onStateChanged(state),
        ),
      );

  void _onHomeNavigationStateChanged(HomeNavigationState state) =>
      state.cprSessionInProgress
          ? context.read<CprScreenCubit>().onCprSessionStart()
          : context.read<CprScreenCubit>().onCprSessionStop();

  bool _buildWhen(CprScreenState previous, CprScreenState current) =>
      (current is CprInformation ||
          current is CprSessionStart ||
          current is CprSessionProgress ||
          current is CprSessionSuccess ||
          current is CprSessionSubmit);

  Widget _body(CprScreenState state) => Scaffold(
        appBar: AppBar(
          title: Text(state.runtimeType.toString()),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => state is CprInformation
                ? context.read<HomeNavigationCubit>().onCprSessionStart()
                : context.read<HomeNavigationCubit>().onCprSessionStop(),
            child: Text(
              state is CprInformation ? 'Start session' : 'Stop session',
            ),
          ),
        ),
      );

  // TODO: Implement actions on change in local state
  void _onStateChanged(CprScreenState state) {}
}
