import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';
import 'package:praca_inz/domain/repositories/user_repository.dart';

class AppRepositoryProviders {
  List<RepositoryProvider> get providers => [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        )
      ];
}
