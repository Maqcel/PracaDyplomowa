import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/gen/assets.gen.dart';
import 'package:praca_inz/presentation/widget/button/button_direction.dart';
import 'package:praca_inz/presentation/widget/button/primary_button.dart';

class CprInstructionDialog extends StatelessWidget {
  const CprInstructionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.all(PaddingDimension.large),
        shape: _border(context),
        child: _body(context),
      );

  ShapeBorder _border(BuildContext context) => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(RadiusDimension.circularXLarge),
      );

  Widget _body(BuildContext context) => Container(
        padding: const EdgeInsets.all(PaddingDimension.small),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _titleText(context),
            const SizedBox(
              height: PaddingDimension.small,
            ),
            _instructionImage(context),
            _licenseAttribute(context),
            Padding(
              padding: const EdgeInsets.all(PaddingDimension.mediumSmall),
              child: _buttonRow(context),
            ),
          ],
        ),
      );

  Widget _titleText(BuildContext context) => Text(
        context.localizations.cprInstructionDialogTitleText,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.headline3,
      );

  Widget _instructionImage(BuildContext context) => Image(
        image: Assets.images.cprInfo,
        fit: BoxFit.fill,
      );

  Widget _licenseAttribute(BuildContext context) => Text(
        context.localizations.cprInstructionDialogAuthorCredits,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.overline,
      );

  Widget _buttonRow(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _dismissButton(context),
        ],
      );

  Widget _dismissButton(BuildContext context) => PrimaryButton(
        text: context.localizations.cprInstructionDialogButtonText,
        onPressed: () => _onDismissButtonPress(context),
        direction: ButtonDirection.right,
      );

  void _onDismissButtonPress(BuildContext context) {
    context.navigator.pop(false);
  }
}
