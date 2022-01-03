import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/widget/button/button_color.dart';
import 'package:praca_inz/presentation/widget/button/button_direction.dart';
import 'package:praca_inz/presentation/widget/button/primary_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String _titleString;
  final String _bodyString;
  final String _dismissString;
  final String _confirmString;
  final bool _confirmsUnsafeAction;

  const ConfirmationDialog({
    Key? key,
    required String titleText,
    required String bodyText,
    required String dismissText,
    required String confirmText,
    bool? confirmsUnsafeAction,
  })  : _titleString = titleText,
        _bodyString = bodyText,
        _dismissString = dismissText,
        _confirmString = confirmText,
        _confirmsUnsafeAction = confirmsUnsafeAction ?? false,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _titleText(context),
            const SizedBox(
              height: PaddingDimension.small,
            ),
            _bodyText(context),
            const SizedBox(
              height: PaddingDimension.medium,
            ),
            _buttonRow(context),
          ],
        ),
      );

  Widget _titleText(BuildContext context) => Text(
        _titleString,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.headline3,
      );

  Widget _bodyText(BuildContext context) => Text(
        _bodyString,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.bodyText1,
      );

  Widget _buttonRow(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _dismissButton(context),
          const SizedBox(
            width: PaddingDimension.small,
          ),
          _confirmButton(context),
        ],
      );

  Widget _dismissButton(BuildContext context) => PrimaryButton(
        text: _dismissString,
        onPressed: () => _onDismissButtonPress(context),
        direction: ButtonDirection.right,
      );

  Widget _confirmButton(BuildContext context) => PrimaryButton(
        text: _confirmString,
        onPressed: () => _onConfirmButtonPress(context),
        buttonColor:
            _confirmsUnsafeAction ? ButtonColor.red : ButtonColor.green,
        direction: ButtonDirection.left,
      );

  void _onDismissButtonPress(BuildContext context) {
    context.navigator.pop(false);
  }

  void _onConfirmButtonPress(BuildContext context) {
    context.navigator.pop(true);
  }
}
