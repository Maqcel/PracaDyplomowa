import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/config/dimensions/animation_dimension.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/domain/failures/authorization_failure.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:praca_inz/presentation/common/common_failure_handler.dart';
import 'package:praca_inz/presentation/screens/auth/login/cubit/login_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/auth/widgets/email_form_input.dart';
import 'package:praca_inz/presentation/screens/auth/widgets/error_container.dart';
import 'package:praca_inz/presentation/screens/auth/widgets/password_form_input.dart';
import 'package:praca_inz/presentation/widget/background_mesh.dart';
import 'package:praca_inz/presentation/widget/button/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with CommonFailureHandler {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final FocusNode _passwordInputFocusNode =
      FocusNode(debugLabel: 'PasswordInputFocusNode');

  @override
  void initState() {
    super.initState();
    _emailInputController.addListener(() => {_onLoginDataChanged()});
    _passwordInputController.addListener(() => {_onLoginDataChanged()});
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<LoginScreenCubit, LoginScreenState>(
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  Widget _body(LoginScreenState state) => Scaffold(
        body: Stack(children: [
          const BackgroundMesh(
            shader: ColorPalette.colorPrimary1000,
            foreground: ColorPalette.colorPrimary800,
          ),
          Padding(
            padding: const EdgeInsets.all(PaddingDimension.medium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _loginFormContainer(state),
              ],
            ),
          ),
        ]),
      );

  Widget _loginFormContainer(LoginScreenState state) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(RadiusDimension.circularMedium),
          color: context.theme.backgroundColor,
        ),
        padding: const EdgeInsets.all(PaddingDimension.medium),
        child: Column(
          children: [
            _errorContainer(state),
            _labelRow(context.localizations.authScreenInputEmailLabel),
            const SizedBox(
              height: PaddingDimension.small,
              width: double.infinity,
            ),
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(RadiusDimension.circularSmall),
              child: EmailFormInput(
                controller: _emailInputController,
                onEditingComplete: () => _onEmailInputEditingComplete(),
              ),
            ),
            const SizedBox(
              height: PaddingDimension.medium,
              width: double.infinity,
            ),
            _labelRow(context.localizations.authScreenInputPasswordLabel),
            const SizedBox(
              height: PaddingDimension.small,
              width: double.infinity,
            ),
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(RadiusDimension.circularSmall),
              child: PasswordFormInput(
                focusNode: _passwordInputFocusNode,
                controller: _passwordInputController,
              ),
            ),
            const SizedBox(
              height: PaddingDimension.large,
              width: double.infinity,
            ),
            _loginButtonRow(state.allowLogin)
          ],
        ),
      );

  Widget _errorContainer(LoginScreenState state) => AnimatedSize(
        duration: AnimDimension.durationMedium,
        child: (state is LoginError && state.failure is AuthorizationFailure)
            ? _error(state)
            : const SizedBox.shrink(),
      );

  Widget _error(LoginError state) => Column(
        children: [
          ErrorContainer(
            message: state.failure.message,
          ),
          const SizedBox(
            height: PaddingDimension.medium,
            width: double.infinity,
          ),
        ],
      );

  Widget _labelRow(String text) => Row(
        children: [
          Text(
            text,
            style: context.theme.textTheme.subtitle1,
          )
        ],
      );

  Widget _loginButtonRow(bool allowLogin) => Row(
        children: [
          PrimaryButton(
            text: context.localizations.authScreenButtonLoginText,
            isEnabled: allowLogin,
            onPressed: () => _onLoginButtonClicked(),
          )
        ],
      );

  void _onEmailInputEditingComplete() {
    context.focusScope.requestFocus(_passwordInputFocusNode);
  }

  void _onLoginDataChanged() {
    String email = _emailInputController.text;
    String password = _passwordInputController.text;
    context.read<LoginScreenCubit>().onLoginDataChanged(email, password);
  }

  void _onLoginButtonClicked() {
    String email = _emailInputController.text;
    String password = _passwordInputController.text;
    context.focusScope.unfocus();
    context.read<LoginScreenCubit>().onLoginButtonClicked(email, password);
  }

  void _onStateChanged(LoginScreenState state) {
    if (state is LoginSuccess) {
      context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    } else if (state is LoginError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }
}
