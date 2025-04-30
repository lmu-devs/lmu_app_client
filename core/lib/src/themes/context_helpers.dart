import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'colors/lmu_colors_theme_extension.dart';
import 'texts/lmu_text_theme.dart';
import 'texts/text_themes_definitions.dart';

extension ThemeGetter on BuildContext {
  LmuColors get colors => Theme.of(this).extension<LmuColors>()!;
}

extension TextThemeGetter on BuildContext {
  LmuTextTheme get textTheme => getBaseTextTheme(
        "Inter",
        Theme.of(this).extension<LmuColors>()!.neutralColors.textColors,
      );
}

extension ModalBottomSheetScrollControllerGetter on BuildContext {
  ScrollController get modalScrollController => ModalScrollController.of(this)!;
}
