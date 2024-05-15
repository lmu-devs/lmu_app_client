import 'package:flutter/material.dart';

import 'neutral_colors.dart';
import 'mensa_colors.dart';
import 'brand_colors.dart';

class JoyColors extends ThemeExtension<JoyColors> {
  const JoyColors({
    required this.neutralColors,
    required this.mensaColors,
    required this.brandColors,
  });

  final NeutralColors neutralColors;
  final MensaColors mensaColors;
  final BrandColors brandColors;

  @override
  JoyColors copyWith({
    Color? brandColor,
    Color? danger,
    NeutralColors? neutralColors,
    MensaColors? mensaColors,
    BrandColors? brandColors,
  }) {
    return JoyColors(
      neutralColors: neutralColors ?? this.neutralColors,
      mensaColors: mensaColors ?? this.mensaColors,
      brandColors: brandColors ?? this.brandColors,
    );
  }

  @override
  JoyColors lerp(JoyColors? other, double t) {
    if (other is! JoyColors) {
      return this;
    }
    return JoyColors(
      neutralColors: neutralColors,
      mensaColors: mensaColors,
      brandColors: brandColors,
    );
  }
}
