import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class ErrorContainer extends StatelessWidget {
  final String? _message;

  const ErrorContainer({Key? key, String? message})
      : _message = message,
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: _decoration(context),
        child: Padding(
          padding: const EdgeInsets.all(PaddingDimension.small),
          child: _text(context),
        ),
      );

  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
        color: context.theme.colorScheme.error.withOpacity(0.1),
        borderRadius: const BorderRadius.all(RadiusDimension.circularSmall),
      );

  Widget _text(BuildContext context) => Text(
        _message ?? context.localizations.errorMessageUnexpected,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.bodyText1?.copyWith(
          color: context.theme.colorScheme.error,
        ),
      );
}
