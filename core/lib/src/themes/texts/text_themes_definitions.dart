import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'lmu_text_theme.dart';

LmuTextTheme getBaseTextTheme(
  String fontFamily,
  TextColors textColors,
) {
  return LmuTextTheme(
    body: TextStyle(
      fontSize: 16,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: textColors.strongColors.base,
      height: 24 / 16,
      letterSpacing: 0,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      color: textColors.strongColors.base,
      fontWeight: FontWeight.w400,
      height: 20 / 14,
      letterSpacing: 0,
    ),
    bodyXSmall: TextStyle(
      fontSize: 12,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      color: textColors.strongColors.base,
      fontWeight: FontWeight.w400,
      height: 19.2 / 12,
      letterSpacing: 0,
    ),
    h0: TextStyle(
      fontSize: 30,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      color: textColors.strongColors.base,
      height: 40 / 30,
    ),
    h1: TextStyle(
      fontSize: 26,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: textColors.strongColors.base,
      height: 36 / 26,
      letterSpacing: -0.52,
    ),
    h2: TextStyle(
      fontSize: 26,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      color: textColors.strongColors.base,
      height: 1.25,
      letterSpacing: -0.52,
    ),
    h3: TextStyle(
      fontSize: 18,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: textColors.strongColors.base,
      height: 24 / 18,
      letterSpacing: -0.36,
    ),
  );
}
