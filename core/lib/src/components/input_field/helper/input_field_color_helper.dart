import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:core/themes.dart';

class InputFieldColorHelper {
  static Color getFillColor(BuildContext context, InputState state) {
    switch (state) {
      case InputState.active:
      case InputState.typing:
        return context.colors.neutralColors.backgroundColors.mediumColors.pressed!;
      case InputState.loading:
      case InputState.filled:
      case InputState.base:
        return context.colors.neutralColors.backgroundColors.mediumColors.base;
    }
  }
}
