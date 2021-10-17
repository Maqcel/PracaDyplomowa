import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/widget/button/button_color.dart';
import 'package:praca_inz/presentation/widget/button/button_direction.dart';
import 'package:praca_inz/presentation/widget/button/button_height.dart';

class PrimaryButton extends StatelessWidget {
  final String _buttonText;
  final ButtonHeight _height;
  final bool _expanded;
  final ButtonDirection _direction;
  final ButtonColor _color;
  final bool _isEnabled;
  final Function() _onPressed;

  const PrimaryButton({
    Key? key,
    required String text,
    required Function() onPressed,
    ButtonHeight? height,
    bool? expanded,
    ButtonDirection? direction,
    ButtonColor? buttonColor,
    bool? isEnabled,
    double? minHeight,
    double? minWidth,
  })  : _buttonText = text,
        _height = height ?? ButtonHeight.large,
        _expanded = expanded ?? true,
        _direction = direction ?? ButtonDirection.left,
        _color = buttonColor ?? ButtonColor.green,
        _isEnabled = isEnabled ?? true,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) => _expanded
      ? Expanded(child: _buttonContent(context))
      : _buttonContent(context);

  Widget _buttonContent(BuildContext context) => ElevatedButton(
        onPressed: () => _onButtonPressed(),
        child: _content(context),
        style: ButtonStyle(
          padding: _contentPadding(context),
          elevation: _elevation(),
          backgroundColor: _backgroundColor(context),
          textStyle: _textStyle(context),
          shape: _shape(context),
        ),
      );

  void _onButtonPressed() {
    if (_isEnabled) _onPressed();
  }

  Widget _content(BuildContext context) => Text(
        _buttonText,
        overflow: TextOverflow.ellipsis,
      );

  MaterialStateProperty<double> _elevation() => MaterialStateProperty.all(0);

  MaterialStateProperty<Color> _backgroundColor(BuildContext context) {
    switch (_color) {
      case ButtonColor.green:
        return MaterialStateProperty.all(_isEnabled
            ? context.theme.colorScheme.primary
            : context.theme.disabledColor);
      case ButtonColor.red:
        return MaterialStateProperty.all(_isEnabled
            ? context.theme.colorScheme.error
            : context.theme.disabledColor);
    }
  }

  MaterialStateProperty<TextStyle?> _textStyle(BuildContext context) {
    if (_height == ButtonHeight.small) {
      return MaterialStateProperty.all(
          context.theme.textTheme.button?.copyWith(fontSize: 13));
    } else {
      return MaterialStateProperty.all(context.theme.textTheme.button);
    }
  }

  MaterialStateProperty<EdgeInsets> _contentPadding(BuildContext context) =>
      MaterialStateProperty.all(_expanded
          ? _expandedContentPadding(context)
          : _shrinkContentPadding(context));

  EdgeInsets _expandedContentPadding(BuildContext context) {
    switch (_height) {
      case ButtonHeight.small:
        return const EdgeInsets.only(
          top: PaddingDimension.xSmall,
          bottom: PaddingDimension.xSmall,
          left: PaddingDimension.small,
          right: PaddingDimension.small,
        );
      case ButtonHeight.medium:
        return const EdgeInsets.only(
          top: PaddingDimension.small,
          bottom: PaddingDimension.small,
          left: PaddingDimension.small,
          right: PaddingDimension.small,
        );
      case ButtonHeight.large:
        return const EdgeInsets.only(
          top: PaddingDimension.mediumSmall,
          bottom: PaddingDimension.mediumSmall,
          left: PaddingDimension.small,
          right: PaddingDimension.small,
        );
    }
  }

  EdgeInsets _shrinkContentPadding(BuildContext context) {
    switch (_height) {
      case ButtonHeight.small:
        return const EdgeInsets.only(
          top: PaddingDimension.xSmall,
          bottom: PaddingDimension.xSmall,
          left: PaddingDimension.medium,
          right: PaddingDimension.medium,
        );
      case ButtonHeight.medium:
        return const EdgeInsets.only(
          top: PaddingDimension.small,
          bottom: PaddingDimension.small,
          left: PaddingDimension.mediumLarge,
          right: PaddingDimension.mediumLarge,
        );
      case ButtonHeight.large:
        return const EdgeInsets.only(
          top: PaddingDimension.mediumSmall,
          bottom: PaddingDimension.mediumSmall,
          left: PaddingDimension.large,
          right: PaddingDimension.large,
        );
    }
  }

  MaterialStateProperty<OutlinedBorder> _shape(BuildContext context) =>
      MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: _outlineRadius(),
      ));

  BorderRadius _outlineRadius() {
    switch (_direction) {
      case ButtonDirection.left:
        return const BorderRadius.only(
          topLeft: RadiusDimension.circularLarge,
          bottomRight: RadiusDimension.circularLarge,
        );

      case ButtonDirection.right:
        return const BorderRadius.only(
          topRight: RadiusDimension.circularLarge,
          bottomLeft: RadiusDimension.circularLarge,
        );
    }
  }
}
