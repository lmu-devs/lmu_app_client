import 'package:flutter/material.dart';

import 'neutral_colors.dart';
import 'mensa_colors.dart';
import 'brand_colors.dart';

class LmuColors extends ThemeExtension<LmuColors> {
  const LmuColors({
    required this.neutralColors,
    required this.mensaColors,
    required this.brandColors,
  });

  final NeutralColors neutralColors;
  final MensaColors mensaColors;
  final BrandColors brandColors;

  @override
  LmuColors copyWith({
    Color? brandColor,
    Color? danger,
    NeutralColors? neutralColors,
    MensaColors? mensaColors,
    BrandColors? brandColors,
  }) {
    return LmuColors(
      neutralColors: neutralColors ?? this.neutralColors,
      mensaColors: mensaColors ?? this.mensaColors,
      brandColors: brandColors ?? this.brandColors,
    );
  }

  @override
  LmuColors lerp(LmuColors? other, double t) {
    if (other is! LmuColors) {
      return this;
    }
    return LmuColors(
      neutralColors: neutralColors,
      mensaColors: mensaColors,
      brandColors: brandColors,
    );
  }
}
