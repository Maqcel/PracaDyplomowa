import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/widget/button/button_direction.dart';
import 'package:praca_inz/presentation/widget/button/primary_button.dart';

class CprInfo extends StatelessWidget {
  final Function() _onCprSessionStart;

  const CprInfo({
    Key? key,
    required Function() onCprSessionStart,
  })  : _onCprSessionStart = onCprSessionStart,
        super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          color: ColorPalette.colorBasic100,
          height:
              MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingDimension.small),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: PaddingDimension.medium),
                _titleText(context),
                const Spacer(),
                ..._sessionExplanationContent(context),
                const Spacer(),
                _sessionStartButton(context),
              ],
            ),
          ),
        ),
      );

  Widget _titleText(BuildContext context) => Text(
        context.localizations.cprSessionInformationTitleText,
        style: context.theme.textTheme.headline1,
      );

  List<Widget> _sessionExplanationContent(BuildContext context) => [
        context.localizations.cprSessionInformationStepOneText,
        context.localizations.cprSessionInformationStepTwoText,
        context.localizations.cprSessionInformationStepThreeText,
        context.localizations.cprSessionInformationStepFourText,
      ].mapIndexed((index, text) => _stepCard(context, ++index, text)).toList();

  Widget _stepCard(
    BuildContext context,
    int index,
    String text,
  ) =>
      Card(
        elevation: PaddingDimension.xSmall,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(RadiusDimension.circularLarge),
        ),
        child: Padding(
          padding: const EdgeInsets.all(PaddingDimension.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                child: Text(
                  index.toString(),
                  style: context.theme.textTheme.headline3
                      ?.copyWith(color: ColorPalette.colorBasic0),
                ),
              ),
              const SizedBox(width: PaddingDimension.small),
              Expanded(
                child: Text(
                  text,
                  softWrap: true,
                  style: context.theme.textTheme.bodyText1,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _sessionStartButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: PaddingDimension.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryButton(
              text: context.localizations.cprInformationStartSessionButtonText,
              onPressed: () => _onCprSessionStart(),
              direction: ButtonDirection.right,
            )
          ],
        ),
      );
}
