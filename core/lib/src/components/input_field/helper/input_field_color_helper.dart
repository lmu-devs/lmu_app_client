import 'package:flutter/material.dart';
import 'package:core/themes.dart';

class InputFieldColorHelper {
  static Color getFillColor(BuildContext context) {
    return context.colors.neutralColors.backgroundColors.mediumColors.base;
  }
}

Color _getFillColor(BuildContext context) {
  return WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return context.colors.neutralColors.backgroundColors.mediumColors.base;
    }
    if (states.contains(WidgetState.focused)) {
      return context
          .colors.neutralColors.backgroundColors.mediumColors.pressed!;
    }
    if (states.contains(WidgetState.hovered)) {
      return context
          .colors.neutralColors.backgroundColors.mediumColors.pressed!;
    }
    return context.colors.neutralColors.backgroundColors.mediumColors.base;
  });
}
