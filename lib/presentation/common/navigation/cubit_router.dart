import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/di/service_locator.dart';
import 'package:praca_inz/presentation/common/navigation/navigation_cubit.dart';

/// RouterDelegate based on BLoC approach with usage of [Cubit] to manage it's state
/// Contains code for back button handling and popping events on nested routes
/// Router sends information about the pop event occurrence back to [NavigationCubit]
/// [C] - Cubit instance of [NavigationCubit]
/// [S] - State of the Cubit [C]
/// [T] - Route Type configuration passed to inherited [RouterDelegate]
abstract class CubitRouter<C extends NavigationCubit<S>, S, T>
    extends RouterDelegate<T>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<T> {
  abstract final GlobalKey<NavigatorState> internalNavigationKey;

  /// This key is required by [PopNavigatorRouterDelegateMixin]
  /// It's used to locale [Navigator] that should handle pop event
  /// Both [Navigator.key] and [PopNavigatorRouterDelegateMixin.navigatorKey]
  /// Needs to be the same key
  @override
  GlobalKey<NavigatorState> get navigatorKey => internalNavigationKey;

  @override
  Widget build(BuildContext context) => BlocBuilder<C, S>(
        builder: (context, state) => Navigator(
          key: internalNavigationKey,
          observers: [
            FirebaseAnalyticsObserver(
              analytics: ServiceLocator.get<FirebaseAnalytics>(),
            ),
          ],
          onPopPage: (route, dynamic result) =>
              _popPage(context, route, result),
          pages: getPageStack(context, state),
        ),
      );

  /// Attempt to pop given route, if attempt is a success
  /// Triggers [NavigationCubit.onRoutePop] method to update navigation state
  /// After that returns the result of [Route.didPop]
  bool _popPage(BuildContext context, Route route, dynamic result) {
    bool didPop = route.didPop(result);
    if (didPop) context.read<C>().onRoutePop(route.settings.name);
    return didPop;
  }

  /// Method that returns the stack of pages (screens) based on provided states [S]
  /// This method has to be overridden in descendant classes
  List<Page> getPageStack(BuildContext context, S state);

  @override
  Future<void> setNewRoutePath(T configuration) => throw UnimplementedError();
}
