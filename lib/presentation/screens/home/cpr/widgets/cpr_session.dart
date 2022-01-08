import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/domain/models/session_result.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/screens/home/cpr/cubit/cpr_screen_cubit.dart';
import 'package:praca_inz/presentation/widget/background_mesh.dart';
import 'package:praca_inz/presentation/widget/button/button_direction.dart';
import 'package:praca_inz/presentation/widget/button/primary_button.dart';

class CprSession extends StatelessWidget {
  final CprScreenState _state;
  final Function(SessionResult) _onSubmitSessionClicked;

  const CprSession({
    Key? key,
    required CprScreenState state,
    required Function(SessionResult) onSubmitSessionClicked,
  })  : _state = state,
        _onSubmitSessionClicked = onSubmitSessionClicked,
        super(key: key);

  @override
  Widget build(BuildContext context) => Stack(children: [
        const BackgroundMesh(
          shader: ColorPalette.colorPrimary1000,
          foreground: ColorPalette.colorPrimary800,
        ),
        Padding(
            padding: const EdgeInsets.all(PaddingDimension.large),
            child: _cprSessionContent(context)),
      ]);

  Widget _cprSessionContent(BuildContext context) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(RadiusDimension.circularMedium),
            color: context.theme.backgroundColor,
          ),
          padding: const EdgeInsets.all(PaddingDimension.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_state is CprSessionProgress)
                _currentTimeLeft(
                  context,
                  (_state as CprSessionProgress).timeLeft,
                ),
              ..._sessionResultContent(
                context,
                _state is CprSessionProgress
                    ? (_state as CprSessionProgress).currentResults
                    : (_state as CprSessionSubmit).sessionResult,
              ),
              if (_state is CprSessionSubmit)
                _submitButton(
                  context,
                  (_state as CprSessionSubmit).sessionResult,
                ),
            ],
          ),
        ),
      );

  Widget _currentTimeLeft(BuildContext context, int timeLeft) => Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.timer_sharp,
            size: 130,
            color: ColorPalette.colorBasic0,
          ),
          Positioned(
            bottom: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: ColorPalette.colorPrimary1000,
              ),
              child: Center(
                child: Text(
                  timeLeft.toString(),
                  style: context.theme.textTheme.headline1
                      ?.copyWith(color: ColorPalette.colorBasic0),
                ),
              ),
            ),
          ),
        ],
      );

  List<Widget> _sessionResultContent(
    BuildContext context,
    SessionResult sessionResult,
  ) =>
      [
        context.localizations.cprSessionSessionResultsCompressionsCountText(
            sessionResult.numberOfChestCompressions),
        context.localizations
            .cprSessionSessionResultsAverageCompressionRateText(
                sessionResult.averageCompressionsRate.toStringAsFixed(2)),
        context.localizations
            .cprSessionSessionResultsTemporaryAverageCompressionRateText(
          sessionResult.temporaryCompressionRate.isNotEmpty
              ? sessionResult.temporaryCompressionRate.last.toStringAsFixed(2)
              : context.localizations
                  .cprSessionSessionResultsTemporaryNoCompressionsText,
        )
      ]
          .map((text) => Card(
                elevation: PaddingDimension.xSmall,
                child: Padding(
                  padding: const EdgeInsets.all(PaddingDimension.small),
                  child: Text(
                    text,
                    style: context.theme.textTheme.headline3,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          .toList();

  Widget _submitButton(
    BuildContext context,
    SessionResult sessionResult,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: PaddingDimension.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryButton(
              text: context.localizations.cprSessionSubmitButtonText,
              onPressed: () => _onSubmitSessionClicked(sessionResult),
              direction: ButtonDirection.right,
            )
          ],
        ),
      );
}
