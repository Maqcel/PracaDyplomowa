import 'package:flutter/material.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class CprInfo extends StatelessWidget {
  final Function() _onCprSessionStart;

  const CprInfo({
    Key? key,
    required Function() onCprSessionStart,
  })  : _onCprSessionStart = onCprSessionStart,
        super(key: key);

  @override
  Widget build(BuildContext context) => Center(
          child: ElevatedButton(
        onPressed: () => _onCprSessionStart(),
        child: Text(context.localizations.cprInformationStartSessionButtonText),
      ));
}
