import 'package:flutter/material.dart';

import 'lmu_colors_theme_extension.dart';

extension ThemeGetter on BuildContext {
  LmuColors get colors => Theme.of(this).extension<LmuColors>()!;
}
