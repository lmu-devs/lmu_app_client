import 'package:flutter/material.dart';
import 'color_primitives.dart';

class ColorSchemes {
  static const ColorScheme light = ColorScheme.light(
      background: ColorPrimitives.grey0,
      primary: ColorPrimitives.lmuGreen70,
      onPrimary: ColorPrimitives.white,
      secondary: ColorPrimitives.grey,
      onSecondary: ColorPrimitives.grey600,
      onBackground: Colors.grey,
      surface: ColorPrimitives.white,
      
      brightness: Brightness.light);

  static const ColorScheme dark = ColorScheme.dark(
    background: ColorPrimitives.grey700,
    primary: ColorPrimitives.lmuGreen70,
    secondary: ColorPrimitives.grey600,
    onBackground: Colors.grey,
  );
}
