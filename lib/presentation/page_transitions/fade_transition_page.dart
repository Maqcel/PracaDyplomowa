import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/animation_dimension.dart';
import 'package:praca_inz/routing/route_definition.dart';

class FadeTransitionPage<T> extends Page<T> {
  final Widget child;
  final Duration duration;

  const FadeTransitionPage({
    required LocalKey? key,
    required String name,
    required this.child,
    this.duration = AnimDimension.durationShort,
  }) : super(key: key, name: name);

  factory FadeTransitionPage.fromRoute({
    required RouteDefinition route,
    required Widget child,
  }) =>
      FadeTransitionPage<T>(
        key: route.valueKey,
        name: route.name,
        child: child,
      );

  @override
  Route<T> createRoute(BuildContext context) {
    return PageBasedFadeTransitionRoute<T>(this);
  }
}

class PageBasedFadeTransitionRoute<T> extends PageRoute<T> {
  final FadeTransitionPage<T> page;

  PageBasedFadeTransitionRoute(this.page) : super(settings: page);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => page.duration;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    CurveTween curveTween = CurveTween(curve: Curves.easeIn);
    return FadeTransition(
      opacity: animation.drive(curveTween),
      child: (settings as FadeTransitionPage).child,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
