import 'dart:ui';

import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';

enum Semester { winter24_25, summer25, winter25_26 }

enum SemesterState { finished, inProgress, upcoming }

extension SemesterLocalizedName on Semester {
  String localizedName(BuildContext context) {
    final locals = context.locals.app;
    return switch (this) {
      Semester.winter24_25 => "${locals.winterCaps} 24/25",
      Semester.summer25 => "${locals.summerCaps} 25",
      Semester.winter25_26 => "${locals.winterCaps} 25/26",
    };
  }

  Color toBackgroundColor(LmuColors colors) {
    return switch (this) {
      Semester.winter24_25 => colors.customColors.backgroundColors.pink,
      Semester.summer25 => colors.customColors.backgroundColors.pink,
      Semester.winter25_26 => colors.customColors.backgroundColors.pink,
    };
  }
}
