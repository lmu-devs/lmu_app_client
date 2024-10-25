import 'package:flutter/material.dart';

import 'neutral_colors.dart';
import 'mensa_colors.dart';
import 'brand_colors.dart';
import 'success_colors.dart';
import 'danger_colors.dart';
import 'warning_colors.dart';

class LmuColors extends ThemeExtension<LmuColors> {
  const LmuColors({
    required this.neutralColors,
    required this.mensaColors,
    required this.brandColors,
    required this.successColors,
    required this.dangerColors,
    required this.warningColors,
  });

  final NeutralColors neutralColors;
  final MensaColors mensaColors;
  final BrandColors brandColors;
  final SuccessColors successColors;
  final DangerColors dangerColors;
  final WarningColors warningColors;

  @override
  LmuColors copyWith({
    Color? brandColor,
    Color? danger,
    NeutralColors? neutralColors,
    MensaColors? mensaColors,
    BrandColors? brandColors,
    SuccessColors? successColors,
    DangerColors? dangerColors,
    WarningColors? warningColors,
  }) {
    return LmuColors(
      neutralColors: neutralColors ?? this.neutralColors,
      mensaColors: mensaColors ?? this.mensaColors,
      brandColors: brandColors ?? this.brandColors,
      successColors: successColors ?? this.successColors,
      dangerColors: dangerColors ?? this.dangerColors,
      warningColors: warningColors ?? this.warningColors,
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
      successColors: successColors,
      dangerColors: dangerColors,
      warningColors: warningColors,
    );
  }
}
