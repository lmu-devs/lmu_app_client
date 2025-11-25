import 'dart:io';

import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

part 'bmw_theme_background_new_driver.g.dart';

@GenerateTestDriver()
class BmwThemeBackgroundNewDriver extends WidgetDriver {
  @TestDriverDefaultValue(Rect.fromLTRB(0, 0, 1000, 1000))
  Rect get backgroundRect => Rect.fromLTWH(
        0,
        0,
        0,
        0 * 0.6,
      );

  Color get backgroundColor {
    return Colors.red;
  }

  FileImage? get imageFile => null;

  File? get animationFile => null;
}
