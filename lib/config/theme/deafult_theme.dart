import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/config/theme/default_text_styles.dart';
import 'package:praca_inz/config/theme/text_styles_definition.dart';
import 'package:praca_inz/config/theme/theme_definition.dart';

class DefaultTheme extends ThemeDefinition {
  static final TextStylesDefinition textStyles = DefaultTextStyles();

  @override
  Brightness brightness = Brightness.dark;

  @override
  ColorScheme get colorScheme => ColorScheme(
        primary: ColorPalette.colorPrimary1000,
        primaryVariant: ColorPalette.colorPrimary900,
        secondary: ColorPalette.colorSecondary1000,
        secondaryVariant: ColorPalette.colorSecondary900,
        surface: ColorPalette.colorBasic1000,
        background: ColorPalette.colorBasic900,
        error: ColorPalette.colorError,
        onPrimary: ColorPalette.colorBasic0,
        onSecondary: ColorPalette.colorBasic0,
        onSurface: ColorPalette.colorBasic0,
        onBackground: ColorPalette.colorBasic0,
        onError: ColorPalette.colorBasic0,
        brightness: brightness,
      );

  @override
  Color scaffoldBackgroundColor = ColorPalette.colorBasic900;

  @override
  Color disabledColor = ColorPalette.colorBasic800;

  @override
  Color textHintColor = ColorPalette.colorBasic100;

  @override
  TextTheme text = textStyles.textTheme;

  @override
  AppBarTheme appBar = AppBarTheme(
    color: ColorPalette.colorBasic900,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: textStyles.textNavigationBar,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  @override
  BottomNavigationBarThemeData bottomNavigationBar =
      BottomNavigationBarThemeData(
    backgroundColor: ColorPalette.colorBasic900,
    selectedLabelStyle: textStyles.textHeadline6.copyWith(
      color: ColorPalette.colorPrimary1000,
      fontSize: 12,
    ),
    unselectedLabelStyle: textStyles.textHeadline6,
    selectedItemColor: ColorPalette.colorPrimary1000,
    unselectedItemColor: ColorPalette.colorBasic100,
    showUnselectedLabels: true,
  );

  @override
  TabBarTheme tabBarTheme = TabBarTheme(
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(
        color: ColorPalette.colorPrimary1000,
        width: 2.0,
      ),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: ColorPalette.colorPrimary1000,
    labelStyle: textStyles.textTabBar,
    unselectedLabelColor: ColorPalette.colorBasic100,
    unselectedLabelStyle: textStyles.textTabBar,
  );

  @override
  TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all(ColorPalette.colorPrimary1000),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        textStyle: MaterialStateProperty.all(textStyles.textTextButton),
        elevation: MaterialStateProperty.all(0)),
  );

  @override
  TextSelectionThemeData textSelectionTheme = const TextSelectionThemeData(
    cursorColor: ColorPalette.colorPrimary1000,
    selectionColor: ColorPalette.colorSecondary900,
    selectionHandleColor: ColorPalette.colorPrimary1000,
  );

  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
        contentTextStyle: textStyles.textLabel1.copyWith(
          color: ColorPalette.colorBasic0,
        ),
        backgroundColor: ColorPalette.colorBasic1000,
      );
}
