import 'package:flutter/material.dart';

import 'neutral_colors.dart';

class JoyColors extends ThemeExtension<JoyColors> {
  const JoyColors({
    required this.neutralColors,
  });

  final NeutralColors neutralColors;

  @override
  JoyColors copyWith({
    Color? brandColor,
    Color? danger,
    NeutralColors? neutralColors,
  }) {
    return JoyColors(
      neutralColors: neutralColors ?? this.neutralColors,
    );
  }

  @override
  JoyColors lerp(JoyColors? other, double t) {
    if (other is! JoyColors) {
      return this;
    }
    return JoyColors(
      neutralColors: neutralColors,
    );
  }
}
