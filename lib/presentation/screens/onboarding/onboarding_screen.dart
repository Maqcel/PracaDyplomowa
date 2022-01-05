import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:praca_inz/presentation/screens/onboarding/cubit/onboarding_screen_cubit.dart';
import 'package:praca_inz/presentation/screens/onboarding/widgets/onboarding_group_picker.dart';
import 'package:praca_inz/presentation/screens/onboarding/widgets/onboarding_input_field.dart';
import 'package:praca_inz/presentation/widget/background_mesh.dart';
import 'package:praca_inz/presentation/widget/button/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _surnameInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OnboardingScreenCubit>().initOnboarding();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<OnboardingScreenCubit, OnboardingScreenState>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  bool _buildWhen(
    OnboardingScreenState previous,
    OnboardingScreenState current,
  ) =>
      (current is OnboardingInProgress || current is OnboardingStatus);

  Widget _body(OnboardingScreenState state) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            const BackgroundMesh(
              shader: ColorPalette.colorPrimary1000,
              foreground: ColorPalette.colorPrimary800,
            ),
            state is OnboardingStatus
                ? Padding(
                    padding: const EdgeInsets.all(PaddingDimension.medium),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _onboardingFormContainer(state),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(
                    color: ColorPalette.colorBasic0,
                  ),
          ],
        ),
      );

  Widget _onboardingFormContainer(OnboardingStatus state) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(RadiusDimension.circularMedium),
          color: context.theme.backgroundColor,
        ),
        padding: const EdgeInsets.all(PaddingDimension.medium),
        child: Column(
          children: [
            _labelRow(context.localizations.onboardingInputNameLabel),
            const SizedBox(
              height: PaddingDimension.small,
              width: double.infinity,
            ),
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(RadiusDimension.circularSmall),
              child: OnboardingInputField(
                isName: true,
                currentGroup: state.groupId,
                controller: _nameInputController,
                onInputChange: _onOnboardingDataChange,
              ),
            ),
            const SizedBox(
              height: PaddingDimension.medium,
              width: double.infinity,
            ),
            _labelRow(context.localizations.onboardingInputSurnameLabel),
            const SizedBox(
              height: PaddingDimension.small,
              width: double.infinity,
            ),
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(RadiusDimension.circularSmall),
              child: OnboardingInputField(
                isName: false,
                currentGroup: state.groupId,
                controller: _surnameInputController,
                onInputChange: _onOnboardingDataChange,
              ),
            ),
            const SizedBox(
              height: PaddingDimension.medium,
              width: double.infinity,
            ),
            _labelRow(context.localizations.onboardingInputGroupLabel),
            OnboardingGroupPicker(
              currentValue: state.groupId.isEmpty
                  ? state.listOfGroups.first
                  : state.groupId,
              groups: state.listOfGroups,
              onDropdownChange: _onOnboardingDataChange,
            ),
            const SizedBox(
              height: PaddingDimension.medium,
              width: double.infinity,
            ),
            _submitButton(state)
          ],
        ),
      );

  Widget _labelRow(String text) => Row(
        children: [
          Text(
            text,
            style: context.theme.textTheme.subtitle1,
          )
        ],
      );

  void _onOnboardingDataChange({String? groupId, String? currentGroup}) =>
      context.read<OnboardingScreenCubit>().changeOnboardingPersonalData(
            name: _nameInputController.text,
            surname: _surnameInputController.text,
            groupId: groupId ?? currentGroup ?? '',
          );

  Widget _submitButton(OnboardingStatus state) => Row(
        children: [
          PrimaryButton(
            text: context.localizations.onboardingSubmitButtonText,
            onPressed: () =>
                context.read<OnboardingScreenCubit>().finishOnboarding(state),
            isEnabled: state.onboardingCompleted,
          ),
        ],
      );

  void _onStateChanged(OnboardingScreenState state) {
    if (state is OnboardingInProgress) {
      context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    }
  }
}
