import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';
import 'package:praca_inz/domain/repositories/sensors_repository.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cubit/cpr_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/home/profile/cubit/profile_screen_cubit.dart';
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
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<CprScreenCubit>(
            create: (context) => CprScreenCubit(
                sensorsRepository: context.read<SensorsRepository>()),
          ),
          BlocProvider<ProfileScreenCubit>(
            create: (context) => ProfileScreenCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      );
}
