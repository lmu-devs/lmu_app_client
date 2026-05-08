import 'package:flutter/material.dart';

import 'brand_colors.dart';
import 'custom_colors.dart';
import 'danger_colors.dart';
import 'gradient_colors.dart';
import 'neutral_colors.dart';
import 'success_colors.dart';
import 'university_colors.dart';
import 'warning_colors.dart';

class LmuColors extends ThemeExtension<LmuColors> {
  const LmuColors({
    required this.neutralColors,
    required this.customColors,
    required this.brandColors,
    required this.successColors,
    required this.dangerColors,
    required this.warningColors,
    required this.gradientColors,
    required this.universityColors,
  });

  final NeutralColors neutralColors;
  final CustomColors customColors;
  final BrandColors brandColors;
  final SuccessColors successColors;
  final DangerColors dangerColors;
  final WarningColors warningColors;
  final GradientColors gradientColors;
  final UniversityColors universityColors;

  @override
  LmuColors copyWith({
    Color? brandColor,
    Color? danger,
    NeutralColors? neutralColors,
    CustomColors? customColors,
    BrandColors? brandColors,
    SuccessColors? successColors,
    DangerColors? dangerColors,
    WarningColors? warningColors,
    GradientColors? gradientColors,
    UniversityColors? universityColors,
  }) {
    return LmuColors(
      neutralColors: neutralColors ?? this.neutralColors,
      customColors: customColors ?? this.customColors,
      brandColors: brandColors ?? this.brandColors,
      successColors: successColors ?? this.successColors,
      dangerColors: dangerColors ?? this.dangerColors,
      warningColors: warningColors ?? this.warningColors,
      gradientColors: gradientColors ?? this.gradientColors,
      universityColors: universityColors ?? this.universityColors,
    );
  }

  @override
  LmuColors lerp(LmuColors? other, double t) {
    if (other is! LmuColors) {
      return this;
    }
    return LmuColors(
      neutralColors: neutralColors,
      customColors: customColors,
      brandColors: brandColors,
      successColors: successColors,
      dangerColors: dangerColors,
      warningColors: warningColors,
      gradientColors: gradientColors,
      universityColors: universityColors,
    );
  }
}
