import 'package:flutter/material.dart';

abstract class ThemeDefinition {
  abstract final Brightness brightness;
  abstract final ColorScheme colorScheme;
  abstract final Color scaffoldBackgroundColor;
  abstract final Color disabledColor;
  abstract final Color textHintColor;
  abstract final AppBarTheme appBar;
  abstract final BottomNavigationBarThemeData bottomNavigationBar;
  abstract final TabBarTheme tabBarTheme;
  abstract final TextTheme text;
  abstract final TextButtonThemeData textButtonTheme;
  abstract final TextSelectionThemeData textSelectionTheme;
  abstract final SnackBarThemeData snackBarTheme;

  ThemeData get themeData => ThemeData(
        brightness: brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        hintColor: textHintColor,
        appBarTheme: appBar,
        bottomNavigationBarTheme: bottomNavigationBar,
        tabBarTheme: tabBarTheme,
        textTheme: text,
        textButtonTheme: textButtonTheme,
        textSelectionTheme: textSelectionTheme,
        snackBarTheme: snackBarTheme,
      );
}
