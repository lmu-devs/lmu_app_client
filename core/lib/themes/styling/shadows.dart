// lib/themes/styling/shadows.dart
import 'package:flutter/material.dart';

enum ButtonType { PRIMARY, SECONDARY }
enum ThemeMode { LIGHT, DARK }

class ShadowStyles {
  static BoxShadow _primaryLight = BoxShadow(
    color: Colors.grey[300]!,
    blurRadius: 10,
    offset: Offset(2, 2),
  );

  static BoxShadow _primaryDark = BoxShadow(
    color: Colors.grey[700]!,
    blurRadius: 10,
    offset: Offset(2, 2),
  );

  static BoxShadow _secondaryLight = BoxShadow(
    color: Colors.blue[200]!,
    blurRadius: 5,
    offset: Offset(2, 2),
  );

  static BoxShadow _secondaryDark = BoxShadow(
    color: Colors.blue[800]!,
    blurRadius: 5,
    offset: Offset(2, 2),
  );

  static List<BoxShadow> getShadow({required ButtonType type, required ThemeMode theme}) {
    switch (theme) {
      case ThemeMode.LIGHT:
        switch (type) {
          case ButtonType.PRIMARY:
            return [_primaryLight];
          case ButtonType.SECONDARY:
            return [_secondaryLight];
        }
      case ThemeMode.DARK:
        switch (type) {
          case ButtonType.PRIMARY:
            return [_primaryDark];
          case ButtonType.SECONDARY:
            return [_secondaryDark];
        }
    }
  }
}
