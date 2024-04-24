import 'package:flutter/material.dart';

import 'colors/joy_colors_theme_extension.dart';

extension ThemeGetter on BuildContext {
  JoyColors get colors => Theme.of(this).extension<JoyColors>()!;
}
