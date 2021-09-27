import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class GenericInputBox extends StatelessWidget {
  static double defaultHeight = 128;

  final TextEditingController _controller;
  final FocusNode _focusNode;
  final EdgeInsets _scrollPadding;

  GenericInputBox({
    Key? key,
    required TextEditingController controller,
    FocusNode? focusNode,
    EdgeInsets? scrollPadding,
  })  : _controller = controller,
        _focusNode = focusNode ?? FocusNode(debugLabel: 'GenericInput'),
        _scrollPadding =
            scrollPadding ?? const EdgeInsets.all(PaddingDimension.mediumLarge),
        super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        controller: _controller,
        focusNode: _focusNode,
        scrollPadding: _scrollPadding,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLines: 256,
        autocorrect: true,
        style: context.theme.textTheme.caption,
        decoration: _decoration(context),
      );

  InputDecoration _decoration(BuildContext context) => InputDecoration(
        isDense: true,
        hintText: context.localizations.inputBoxDefaultHint,
        contentPadding: const EdgeInsets.all(PaddingDimension.mediumSmall),
        hintStyle: _hintStyle(context),
        border: _idleBorder(context),
        focusedBorder: _focusedBorder(context),
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
}
