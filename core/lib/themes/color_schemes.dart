import 'package:flutter/material.dart';
import 'color_primitives.dart';

class ColorSchemes {
  static const ColorScheme light = ColorScheme.light(
      primary: Color(0xFF1b9945),
      secondary: Color.fromARGB(234, 234, 223, 23),
      background: ColorPrimitives.grey,
      onBackground: Colors.grey,
      surface: ColorPrimitives.white,
      brightness: Brightness.light);

  static const ColorScheme dark = ColorScheme.dark(
    primary: Color(0xFF59AE6B),
    secondary: Color.fromARGB(234, 234, 223, 23),
    background: Colors.black,
    onBackground: Colors.grey,
  );
}
