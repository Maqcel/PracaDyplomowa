import 'package:flutter/material.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class CprSession extends StatelessWidget {
  final Function() _onSubmitSessionClicked;

  const CprSession({
    Key? key,
    required Function() onSubmitSessionClicked,
  })  : _onSubmitSessionClicked = onSubmitSessionClicked,
        super(key: key);

  @override
  Widget build(BuildContext context) => Center(
          child: ElevatedButton(
        onPressed: () => _onSubmitSessionClicked(),
        child: Text(context.localizations.cprSessionSubmitButtonText),
      ));
}
