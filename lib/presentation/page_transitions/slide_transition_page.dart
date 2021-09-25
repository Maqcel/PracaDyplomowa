import 'package:flutter/material.dart';
import 'package:praca_inz/routing/route_definition.dart';

class SlideTransitionPage<T> extends Page<T> {
  final Widget child;
  final Duration duration;

  const SlideTransitionPage({
    required String name,
    required LocalKey? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key, name: name);

  factory SlideTransitionPage.fromRoute({
    required RouteDefinition route,
    required Widget child,
  }) =>
      SlideTransitionPage(
        key: route.valueKey,
        name: route.name,
        child: child,
      );

  @override
  Route<T> createRoute(BuildContext context) =>
      PageBasedSlideTransitionRoute<T>(this);
}

class PageBasedSlideTransitionRoute<T> extends PageRoute<T> {
  final SlideTransitionPage<T> page;

  PageBasedSlideTransitionRoute(this.page) : super(settings: page);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => page.duration;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.ease),
          ),
        ),
        child: (settings as SlideTransitionPage).child,
      );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;
}
