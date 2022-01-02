import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/config/dimensions/animation_dimension.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:praca_inz/presentation/common/common_failure_handler.dart';
import 'package:praca_inz/presentation/dialogs/confirmation_dialog.dart';
import 'package:praca_inz/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/home/profile/cubit/profile_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/home/profile/profile_screen_builder.dart';
import 'package:praca_inz/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';
import 'package:praca_inz/routing/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with CommonFailureHandler {
  @override
  void initState() {
    super.initState();
    context.read<ProfileScreenCubit>().onScreenOpened();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MainNavigationCubit, MainNavigationState>(
        listener: (context, state) => _onMainNavigationStateChanged(state),
        child: BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
          buildWhen: (previous, current) => _buildWhen(previous, current),
          builder: (context, state) => _body(state),
          listener: (context, state) => _onStateChanged(state),
        ),
      );

  bool _buildWhen(ProfileScreenState previous, ProfileScreenState current) =>
      (current is ProfileLoading || current is ProfileLoaded);

  void _onMainNavigationStateChanged(MainNavigationState state) {
    if (state is MainNavigationHome) {
      if (state.previousRoute == AppRoutes.profileSession) {
        context.read<ProfileScreenCubit>().onScreenOpened();
      }
    }
  }

  Widget _body(ProfileScreenState state) => Scaffold(
        body: AnimatedSwitcher(
          duration: AnimDimension.durationShort,
          child: _content(state),
        ),
      );

  Widget _content(ProfileScreenState state) {
    if (state is ProfileLoaded) {
      return _userProfile(state);
    } else {
      return _loadingIndicator();
    }
  }

  Widget _userProfile(ProfileLoaded state) =>
      ProfileScreenBuilder.build(context: context);

  Widget _loadingIndicator() => Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      );

  Future<void> _onLogoutClicked() async {
    bool? logoutConfirmed = await showDialog<bool>(
        context: context,
        builder: (context) => ConfirmationDialog(
              titleText: context.localizations.dialogConfirmationLogoutTitle,
              bodyText: context.localizations.dialogConfirmationLogoutText,
              dismissText: context
                  .localizations.dialogConfirmationLogoutDismissButtonText,
              confirmText: context
                  .localizations.dialogConfirmationLogoutConfirmButtonText,
              confirmsUnsafeAction: true,
            ));

    if (logoutConfirmed == true) {
      context.read<ProfileScreenCubit>().onLogoutClicked();
    }
  }

  void _onStateChanged(ProfileScreenState state) {
    if (state is ProfileLoadError) {
      _onProfileLoadError(state.failure);
    } else if (state is ProfileLoggedOut) {
      _onLogoutSuccess();
    }
  }

  void _onLogoutSuccess() {
    context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    context.read<MainNavigationCubit>().clearState();
    context.read<HomeNavigationCubit>().clearState();
  }

  void _onProfileLoadError(Failure failure) => handleFailureInUi(
        context: context,
        failure: failure,
        onFailureAcknowledged: () =>
            context.read<ProfileScreenCubit>().onScreenOpened(),
      );
}
