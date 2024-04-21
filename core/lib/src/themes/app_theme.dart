library themes;

import 'package:flutter/material.dart';

import 'color_primitives.dart';
import 'color_schemes.dart';
import 'text_themes.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorSchemes.light,
    cardTheme: const CardTheme(
      color: ColorPrimitives.white,
      elevation: 0.0,
    ),
    textTheme: getBaseTextTheme(
      "Inter",
      ColorSchemes.light,
    ),
  );

  static ThemeData dark = ThemeData(
    colorScheme: ColorSchemes.dark,
    cardTheme: const CardTheme(
      color: ColorPrimitives.grey700,
      elevation: 0.0,
    ),
    textTheme: getBaseTextTheme(
      "Inter",
      ColorSchemes.light,
    ),
  );
}
