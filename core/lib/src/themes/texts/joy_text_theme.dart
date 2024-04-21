import 'package:flutter/material.dart';

class JoyTextTheme extends TextTheme {
  const JoyTextTheme({
    required this.body,
    required this.bodySmall,
    required this.bodyXSmall,
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
  }) : super(
          bodySmall: bodyXSmall,
          bodyMedium: bodySmall,
          bodyLarge: body,
          headlineLarge: h0,
          headlineMedium: h1,
          headlineSmall: h2,
          titleLarge: h3,
        );

  final TextStyle body;
  @override
  final TextStyle bodySmall;
  final TextStyle bodyXSmall;
  final TextStyle h0;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
}
