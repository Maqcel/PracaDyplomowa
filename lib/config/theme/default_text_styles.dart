import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/config/theme/text_styles_definition.dart';

class DefaultTextStyles extends TextStylesDefinition {
  @override
  TextStyle textTabBar = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 24 / 14,
  );

  @override
  TextStyle textNavigationBar = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    height: 24 / 18,
  );

  @override
  TextStyle textHeadline1 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 34,
    height: 38 / 34,
  );

  @override
  TextStyle textHeadline2 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 23,
    height: 32 / 23,
  );

  @override
  TextStyle textHeadline3 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    height: 32 / 18,
  );

  @override
  TextStyle textHeadline4 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    height: 22 / 16,
  );

  @override
  TextStyle textHeadline5 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 15,
    height: 22 / 15,
  );

  @override
  TextStyle textHeadline6 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 10,
    height: 16 / 10,
  );

  @override
  TextStyle textButton = TextStyle(
    color: ColorPalette.colorBasic0,
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 15,
    height: 24 / 15,
  );

  // I swear this naming convention is right
  @override
  TextStyle textTextButton = TextStyle(
    color: ColorPalette.colorPrimary1000,
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 13,
    height: 24 / 13,
  );

  @override
  TextStyle textLabel1 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 24 / 14,
  );

  @override
  TextStyle textLabel2 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 24 / 12,
  );

  @override
  TextStyle textFormInput = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 24 / 14,
  );

  @override
  TextStyle textParagraph2 = TextStyle(
    color: ColorPalette.colorBasic900,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 15,
    height: 22 / 15,
  );

  @override
  TextStyle textParagraph3 = TextStyle(
    color: ColorPalette.colorBasic700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 16 / 12,
  );
}
