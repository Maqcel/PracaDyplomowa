import 'package:flutter/material.dart';

class CountdownAnimation {
  final AnimationController animationController;
  final Animation<double> currentHeight;
  final Animation<double> currentOpacity;
  final Animation<double> currentSize;
  final Animation<int> countdownDigit;

  CountdownAnimation({required this.animationController})
      : currentHeight =
            Tween<double>(begin: 0.0, end: 1.2).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 1.0, curve: Curves.easeInToLinear),
        )),
        currentOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
          ),
        ),
        currentSize = Tween<double>(begin: 1, end: 0.5).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
          ),
        ),
        countdownDigit = IntTween(begin: 3, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.0, 1.0, curve: Curves.linear),
          ),
        );
}
