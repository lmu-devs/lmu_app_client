import 'package:flutter/material.dart';

class JoyTextTheme extends TextTheme {
  const JoyTextTheme({
    required this.cover,
    required this.point,
    required this.welcome,
    required this.h0,
    required this.status,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.body,
    required this.label,
    required this.caption,
    required this.hints,
  }) : super(
          displayLarge: cover,
          displayMedium: cover,
          displaySmall: cover,
          headlineMedium: status,
          headlineSmall: h1,
          titleLarge: h2,
          titleMedium: h3,
          bodyLarge: body,
          bodyMedium: body,
          bodySmall: label,
          labelLarge: body,
          titleSmall: caption,
          labelSmall: hints,
        );

  final TextStyle cover;
  final TextStyle point;
  final TextStyle welcome;
  final TextStyle h0;
  final TextStyle status;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle body;
  final TextStyle label;

  @override
  final TextStyle caption;
  final TextStyle hints;
}
