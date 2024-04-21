import 'package:flutter/material.dart';

import '../components/texts/joy_text_theme.dart';

JoyTextTheme getBaseTextTheme(String fontFamily, ColorScheme colorScheme) {
  return JoyTextTheme(
    cover: TextStyle(
      fontSize: 82,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 72 / 82,
    ),
    point: TextStyle(
      fontSize: 60,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 80 / 60,
    ),
    welcome: TextStyle(
      fontSize: 36,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 40 / 36,
    ),
    h0: TextStyle(
      fontSize: 30,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 40 / 30,
    ),
    status: TextStyle(
      fontSize: 24,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 32 / 24,
    ),
    h1: TextStyle(
      fontSize: 20,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 28 / 20,
    ),
    h2: TextStyle(
      fontSize: 18,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 24 / 18,
    ),
    h3: TextStyle(
      fontSize: 16,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      height: 20 / 16,
    ),
    body: TextStyle(
      fontSize: 14,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.normal,
      color: colorScheme.primary,
      height: 20 / 14,
    ),
    label: TextStyle(
      fontSize: 12,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.normal,
      color: colorScheme.primary,
      height: 16 / 12,
    ),
    caption: TextStyle(
      fontSize: 10,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.normal,
      color: colorScheme.primary,
      height: 12 / 10,
    ),
    hints: TextStyle(
      fontSize: 8,
      fontFamily: fontFamily,
      package: 'joy_ui',
      fontWeight: FontWeight.normal,
      color: colorScheme.primary,
      height: 12 / 8,
    ),
  );
}
