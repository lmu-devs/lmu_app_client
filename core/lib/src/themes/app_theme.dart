import 'package:flutter/material.dart';

import 'colors/lmu_colors_definitions.dart';
import 'texts/text_themes_definitions.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      lmuColorsLight.neutralColors.textColors,
    ),
    extensions: const <ThemeExtension<dynamic>>[lmuColorsLight],
  );

  static ThemeData dark = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      lmuColorsDark.neutralColors.textColors,
    ),
    extensions: const <ThemeExtension<dynamic>>[lmuColorsDark],
  );
}
