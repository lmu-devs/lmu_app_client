import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class GradeGradientSet {
  const GradeGradientSet({
    required this.backgrounds,
    required this.texts,
    required this.highlights,
  });

  final List<Color> backgrounds;
  final List<Color> texts;
  final List<Color> highlights;
}

extension ColorInterpolation on List<Color> {
  Color interpValue(double value, {required double min, required double max}) {
    if (isEmpty) return Colors.transparent;
    if (length == 1) return first;

    double t = (value - min) / (max - min);
    t = t.clamp(0.0, 1.0);

    double scaledValue = t * (length - 1);
    int index = scaledValue.floor();

    if (index >= length - 1) {
      return last;
    }

    double remainder = scaledValue - index;
    return Color.lerp(this[index], this[index + 1], remainder)!;
  }
}

extension GradesThemeExtension on BuildContext {
  GradeGradientSet get gradeGradientSet {
    final backgroundColors = colors.customColors.backgroundColors;
    final textColors = colors.customColors.textColors;
    final gradientColors = colors.customColors.colorColors;

    return GradeGradientSet(
      backgrounds: [backgroundColors.green, backgroundColors.lime, backgroundColors.amber, backgroundColors.red],
      texts: [textColors.green, textColors.lime, textColors.amber, textColors.red],
      highlights: [gradientColors.green, gradientColors.lime, gradientColors.amber, gradientColors.red],
    );
  }
}
