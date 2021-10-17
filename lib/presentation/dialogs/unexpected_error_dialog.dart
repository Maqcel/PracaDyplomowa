import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/widget/button/button_direction.dart';
import 'package:praca_inz/presentation/widget/button/primary_button.dart';

class UnexpectedErrorDialog extends StatelessWidget {
  final Function()? _onDismiss;

  const UnexpectedErrorDialog({Key? key, Function()? onDismiss})
      : _onDismiss = onDismiss,
        super(key: key);

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
        padding: const EdgeInsets.all(PaddingDimension.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _titleText(context),
            const SizedBox(
              height: PaddingDimension.small,
            ),
            _bodyText(context),
            const SizedBox(
              height: PaddingDimension.medium,
            ),
            _button(context),
          ],
        ),
      );

  Widget _titleText(BuildContext context) => Text(
        context.localizations.dialogUnexpectedErrorTitle,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.headline3,
      );

  Widget _bodyText(BuildContext context) => Text(
        context.localizations.dialogUnexpectedErrorText,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.bodyText1,
      );

  Widget _button(BuildContext context) => Row(
        children: [
          PrimaryButton(
            text: context.localizations.dialogUnexpectedErrorButtonText,
            onPressed: () => _onButtonPress(context),
            direction: ButtonDirection.right,
          )
        ],
      );

  void _onButtonPress(BuildContext context) {
    context.navigator.pop();
    if (_onDismiss != null) {
      _onDismiss!();
    }
  }
}
