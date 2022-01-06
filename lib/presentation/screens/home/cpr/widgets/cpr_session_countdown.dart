import 'package:flutter/material.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';
import 'package:praca_inz/presentation/animations/countdown_animation.dart';
import 'package:praca_inz/presentation/widget/background_mesh.dart';

class CprSessionCountdown extends StatefulWidget {
  const CprSessionCountdown({Key? key}) : super(key: key);

  @override
  _CprSessionCountdownState createState() => _CprSessionCountdownState();
}

class _CprSessionCountdownState extends State<CprSessionCountdown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final CountdownAnimation _countdownAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animationController.forward();
    _countdownAnimation =
        CountdownAnimation(animationController: _animationController);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AnimatedBuilder(
          animation: _countdownAnimation.animationController,
          builder: (context, _) => _animatedContent(context),
        ),
      );

  Widget _animatedContent(BuildContext context) => SizedBox(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const BackgroundMesh(
              shader: ColorPalette.colorPrimary1000,
              foreground: ColorPalette.colorPrimary800,
            ),
            _countdownDigit(context),
          ],
        ),
      );

  Widget _countdownDigit(BuildContext context) => Opacity(
        opacity: _countdownAnimation.currentOpacity.value,
        child: Align(
          alignment: Alignment(0.0, _countdownAnimation.currentHeight.value),
          child: Text(
            _countdownAnimation.countdownDigit.value.toString(),
            style: context.theme.textTheme.headline1?.copyWith(
              color: ColorPalette.colorBasic0,
              fontSize: 150.0 * _countdownAnimation.currentSize.value,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
