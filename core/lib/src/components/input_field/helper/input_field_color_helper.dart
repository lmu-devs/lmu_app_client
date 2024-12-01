import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:core/themes.dart';

class InputFieldColorHelper {
  static Color getFillColor(BuildContext context, InputStates state) {
    switch (state) {
      case InputStates.active:
      case InputStates.typing:
        return context.colors.neutralColors.backgroundColors.mediumColors.pressed!;
      case InputStates.loading:
      case InputStates.filled:
      case InputStates.base:
        return context.colors.neutralColors.backgroundColors.mediumColors.base;
    }
  }
}
