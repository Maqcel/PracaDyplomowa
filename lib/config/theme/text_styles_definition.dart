import 'package:flutter/material.dart';

abstract class TextStylesDefinition {
  abstract final TextStyle textHeadline1;
  abstract final TextStyle textHeadline2;
  abstract final TextStyle textHeadline3;
  abstract final TextStyle textHeadline4;
  abstract final TextStyle textHeadline5;
  abstract final TextStyle textHeadline6;
  abstract final TextStyle textButton;
  abstract final TextStyle textLabel1;
  abstract final TextStyle textLabel2;
  abstract final TextStyle textFormInput;
  abstract final TextStyle textParagraph2;
  abstract final TextStyle textParagraph3;

  /// Values below can't defined in TextTheme itself
  /// But have to be set in parent ThemeData
  abstract final TextStyle textTextButton;
  abstract final TextStyle textNavigationBar;
  abstract final TextStyle textTabBar;

  TextTheme get textTheme => TextTheme(
        headline1: textHeadline1,
        headline2: textHeadline2,
        headline3: textHeadline3,
        headline4: textHeadline4,
        headline5: textHeadline5,
        headline6: textHeadline6,
        button: textButton,
        subtitle1: textLabel1,
        subtitle2: textLabel2,
        caption: textFormInput,
        bodyText1: textParagraph2,
        bodyText2: textParagraph3,
      );
}
