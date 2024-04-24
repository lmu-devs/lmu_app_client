import 'package:flutter/material.dart';

import 'colors/joy_colors_definitions.dart';
import 'texts/text_themes_definitions.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      joyColorsLight.neutralColors.textColors,
    ),
    extensions: const <ThemeExtension<dynamic>>[joyColorsLight],
  );

  static ThemeData dark = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      joyColorsDark.neutralColors.textColors,
    ),
    extensions: const <ThemeExtension<dynamic>>[joyColorsDark],
  );
}
