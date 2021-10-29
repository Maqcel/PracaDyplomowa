import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/auth/navigation/cubit/auth_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';

class AppBlocProviders {
  List<BlocProvider> get providers => [
        BlocProvider<UserSessionNavigationCubit>(
          lazy: false,
          create: (context) => UserSessionNavigationCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<AuthNavigationCubit>(
          lazy: true,
          create: (context) => AuthNavigationCubit(),
        ),
        BlocProvider<MainNavigationCubit>(
          lazy: true,
          create: (context) => MainNavigationCubit(),
        ),
        BlocProvider<HomeNavigationCubit>(
          lazy: true,
          create: (context) => HomeNavigationCubit(),
        ),
      ];
}
