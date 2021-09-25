import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';

class AppBlocProviders {
  List<BlocProvider> get providers => [
        BlocProvider<UserSessionNavigationCubit>(
          lazy: false,
          create: (context) => UserSessionNavigationCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ];
}
