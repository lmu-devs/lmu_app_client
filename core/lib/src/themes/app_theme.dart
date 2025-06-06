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
    colorScheme: const ColorScheme.light().copyWith(
      primary:
          lmuColorsLight.brandColors.backgroundColors.nonInvertableColors.base,
    ),
    scaffoldBackgroundColor: lmuColorsLight.neutralColors.backgroundColors.base,
    cardColor: lmuColorsLight.neutralColors.backgroundColors.base,
    appBarTheme: AppBarTheme(
      backgroundColor: lmuColorsLight.neutralColors.backgroundColors.base,
      elevation: 0,
      surfaceTintColor: lmuColorsLight.neutralColors.backgroundColors.base,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lmuColorsLight.brandColors.textColors.strongColors.base,
      selectionHandleColor:
          lmuColorsLight.brandColors.textColors.strongColors.base,
      selectionColor:
          lmuColorsLight.neutralColors.backgroundColors.mediumColors.base,
    ),
  );

  static ThemeData dark = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      lmuColorsDark.neutralColors.textColors,
    ),
    extensions: const <ThemeExtension<dynamic>>[lmuColorsDark],
    colorScheme: const ColorScheme.dark().copyWith(
      primary:
          lmuColorsDark.brandColors.backgroundColors.nonInvertableColors.base,
    ),
    scaffoldBackgroundColor: lmuColorsDark.neutralColors.backgroundColors.base,
    cardColor: lmuColorsDark.neutralColors.backgroundColors.base,
    cardTheme: CardThemeData(
      color: lmuColorsDark.neutralColors.backgroundColors.base,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lmuColorsDark.neutralColors.backgroundColors.base,
      elevation: 0,
      surfaceTintColor: lmuColorsDark.neutralColors.backgroundColors.base,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lmuColorsDark.brandColors.textColors.strongColors.base,
      selectionHandleColor:
          lmuColorsDark.brandColors.textColors.strongColors.base,
      selectionColor:
          lmuColorsDark.neutralColors.backgroundColors.mediumColors.base,
    ),
  );
}
