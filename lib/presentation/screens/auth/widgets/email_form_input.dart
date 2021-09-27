import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/icon_dimension.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class EmailFormInput extends StatelessWidget {
  final TextEditingController _controller;
  final Function()? _onEditingComplete;

  const EmailFormInput({
    Key? key,
    required TextEditingController controller,
    Function()? onEditingComplete,
  })  : _controller = controller,
        _onEditingComplete = onEditingComplete,
        super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          textInputAction: TextInputAction.next,
          onEditingComplete: _onEditingComplete,
          style: context.theme.textTheme.caption,
          decoration: _decoration(context),
        ),
      );

  InputDecoration _decoration(BuildContext context) => InputDecoration(
        isDense: true,
        hintText: context.localizations.authScreenInputEmailHint,
        contentPadding: const EdgeInsets.only(
          top: PaddingDimension.mediumSmall,
          bottom: PaddingDimension.mediumSmall,
          right: PaddingDimension.mediumSmall,
        ),
        hintStyle: _hintStyle(context),
        border: _idleBorder(context),
        focusedBorder: _focusedBorder(context),
        prefixIcon: _prefixIcon(context),
      );

  TextStyle? _hintStyle(BuildContext context) =>
      context.theme.textTheme.caption?.copyWith(
        color: context.theme.hintColor,
      );

  BorderRadius _borderRadius() =>
      const BorderRadius.all(RadiusDimension.circularSmall);

  InputBorder _idleBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1,
          color: context.theme.hintColor,
        ),
      );

  InputBorder _focusedBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1.5,
          color: context.theme.hintColor,
        ),
      );

  Widget _prefixIcon(BuildContext context) => Padding(
      padding: const EdgeInsets.all(PaddingDimension.mediumSmall),
      child: Icon(
        Icons.mail_outline_rounded,
        color: context.theme.hintColor,
        size: IconDimension.small,
      ));
}
