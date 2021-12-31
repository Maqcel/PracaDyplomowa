import 'package:flutter/material.dart';
import 'package:praca_inz/routing/route_definition.dart';

class AppRoutes {
  static RouteDefinition entry = const RouteDefinition(
    name: '/',
    valueKey: ValueKey('entry'),
  );
  static RouteDefinition splash = const RouteDefinition(
    name: '/splash',
    valueKey: ValueKey('splash'),
  );
  static RouteDefinition login = const RouteDefinition(
    name: '/auth-login',
    valueKey: ValueKey('auth-login'),
  );
  static RouteDefinition signup = const RouteDefinition(
    name: '/auth-signup',
    valueKey: ValueKey('auth-signup'),
  );
  static RouteDefinition home = const RouteDefinition(
    name: '/home',
    valueKey: ValueKey('home'),
  );
  static RouteDefinition homeCprSession = const RouteDefinition(
    name: '/home/cpr-session',
    valueKey: ValueKey('cpr-session'),
  );
  static RouteDefinition homeProfile = const RouteDefinition(
    name: '/home/profile',
    valueKey: ValueKey('profile'),
  );
  static RouteDefinition profileSession = const RouteDefinition(
    name: '/profile/session',
    valueKey: ValueKey('session'),
  );
}
