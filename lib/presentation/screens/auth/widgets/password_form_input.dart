import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/icon_dimension.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class PasswordFormInput extends StatefulWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;

  PasswordFormInput({
    Key? key,
    required TextEditingController controller,
    FocusNode? focusNode,
  })  : _controller = controller,
        _focusNode = focusNode ?? FocusNode(),
        super(key: key);

  @override
  _PasswordFormInputState createState() => _PasswordFormInputState();
}

class _PasswordFormInputState extends State<PasswordFormInput> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) => Material(
        child: TextFormField(
          focusNode: widget._focusNode,
          controller: widget._controller,
          keyboardType: _keyboardType(),
          obscureText: _isPasswordObscured,
          textInputAction: TextInputAction.done,
          style: context.theme.textTheme.caption,
          decoration: _decoration(context),
        ),
      );

  TextInputType _keyboardType() {
    if (_isPasswordObscured) {
      return TextInputType.visiblePassword;
    } else {
      return TextInputType.text;
    }
  }

  InputDecoration _decoration(BuildContext context) => InputDecoration(
      isDense: true,
      hintText: context.localizations.authScreenInputPasswordHint,
      contentPadding: const EdgeInsets.only(
        top: PaddingDimension.mediumSmall,
        bottom: PaddingDimension.mediumSmall,
      ),
      hintStyle: _hintStyle(),
      border: _idleBorder(),
      focusedBorder: _focusedBorder(),
      prefixIcon: _prefixIcon(),
      suffixIcon: _suffixIconButton());

  TextStyle? _hintStyle() => context.theme.textTheme.caption?.copyWith(
        color: context.theme.hintColor,
      );

  BorderRadius _borderRadius() =>
      const BorderRadius.all(RadiusDimension.circularSmall);

  InputBorder _idleBorder() => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1,
          color: context.theme.hintColor,
        ),
      );

  InputBorder _focusedBorder() => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1.5,
          color: context.theme.hintColor,
        ),
      );

  Widget _prefixIcon() => Padding(
      padding: const EdgeInsets.all(PaddingDimension.mediumSmall),
      child: Icon(
        Icons.password_outlined,
        color: context.theme.textTheme.caption?.color,
        size: IconDimension.small,
      ));

  Widget _suffixIconButton() => IconButton(
      padding: const EdgeInsets.all(PaddingDimension.mediumSmall),
      splashRadius: IconDimension.small / 2 + PaddingDimension.mediumSmall,
      onPressed: () => _onObscurePasswordButtonClicked(),
      icon: Icon(
        Icons.remove_red_eye_outlined,
        color: context.theme.textTheme.caption?.color,
        size: IconDimension.small,
      ));

  void _onObscurePasswordButtonClicked() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }
}
