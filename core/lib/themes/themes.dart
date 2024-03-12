library themes;

import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'color_primitives.dart';

export '';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorSchemes.light,
    cardTheme: const CardTheme(
      color: ColorPrimitives.white,
      elevation: 0.0,
    ),
  );
  
  static ThemeData dark = ThemeData(
    colorScheme: ColorSchemes.dark,
    cardTheme: const CardTheme(
      color: ColorPrimitives.grey700,
      elevation: 0.0,
    ),
  );
}
