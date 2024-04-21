import 'package:flutter/material.dart';

import 'models/neutral_colors.dart';

class LmuColors extends ThemeExtension<LmuColors> {
  const LmuColors({
    required this.brandColor,
    required this.danger,
    required this.neutralColors,
  });

  final Color brandColor;
  final Color danger;
  final NeutralColors neutralColors;

  @override
  LmuColors copyWith({
    Color? brandColor,
    Color? danger,
    NeutralColors? neutralColors,
  }) {
    return LmuColors(
      brandColor: brandColor ?? this.brandColor,
      danger: danger ?? this.danger,
      neutralColors: neutralColors ?? this.neutralColors,
    );
  }

  @override
  LmuColors lerp(LmuColors? other, double t) {
    if (other is! LmuColors) {
      return this;
    }
    return LmuColors(
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      neutralColors: neutralColors,
    );
  }
}
