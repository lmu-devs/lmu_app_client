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
    scaffoldBackgroundColor: lmuColorsLight.neutralColors.backgroundColors.base,
    cardColor: lmuColorsLight.neutralColors.backgroundColors.base,
    appBarTheme: AppBarTheme(
      backgroundColor: lmuColorsLight.neutralColors.backgroundColors.base,
      elevation: 0,
      surfaceTintColor: lmuColorsLight.neutralColors.backgroundColors.base,
    ),
  );

  static ThemeData dark = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      lmuColorsDark.neutralColors.textColors,
    ),
    extensions: const <ThemeExtension<dynamic>>[lmuColorsDark],

    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: lmuColorsDark.neutralColors.backgroundColors.base,
    cardColor: lmuColorsDark.neutralColors.backgroundColors.base,
    cardTheme: CardTheme(
      color: lmuColorsDark.neutralColors.backgroundColors.base,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lmuColorsDark.neutralColors.backgroundColors.base,
      elevation: 0,
      surfaceTintColor: lmuColorsDark.neutralColors.backgroundColors.base,
    ),
  );
}
