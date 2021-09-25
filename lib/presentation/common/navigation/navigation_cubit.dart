import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Extension on [Cubit] made to handle the
/// Navigator 2.0 approach for actions and router events
/// [S] - Generic for State of the Cubit
abstract class NavigationCubit<S> extends Cubit<S> {
  final S initialState;
  NavigationCubit({required this.initialState}) : super(initialState);

  @override
  void onChange(Change<S> change) {
    log("Navigator: $runtimeType navigating from ${change.currentState} to ${change.nextState}");
    super.onChange(change);
  }

  /// Method is called when [CubitRouter] receives route pop event
  /// By default route pop is ignored
  void onRoutePop(String? routeName) =>
      log("Navigator: $runtimeType route $routeName popped!");

  void onUnknownRouteName(String? routeName) {
    if (routeName == null) {
      throw ArgumentError.notNull(routeName);
    } else {
      throw ArgumentError.value(routeName, 'routeName',
          'Pop of route $routeName couldn\'t be handled by $runtimeType');
    }
  }

  /// Method can be called when we need to restore [NavigationCubit] to initial state
  void clearState() {
    log("Navigator: $runtimeType restoring state to $initialState");
    emit(initialState);
  }
}
