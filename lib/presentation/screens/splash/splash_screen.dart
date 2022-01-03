import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: Future<dynamic>.delayed(
          const Duration(seconds: 1),
          () => context
              .read<UserSessionNavigationCubit>()
              .onUserSessionStateChanged(),
        ),
        builder: (context, snapshot) => _body(context),
      );

  Widget _body(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: context.theme.colorScheme.primary,
          child: const FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 0.5,
            child: FlutterLogo(),
          ),
        ),
      );
}
