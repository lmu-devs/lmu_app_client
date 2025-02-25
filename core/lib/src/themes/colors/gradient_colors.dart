import 'dart:ui';

class GradientColors {
  const GradientColors({
    required this.gradientLoadingColors,
    required this.gradientFadeColors,
  });

  final GradientLoadingColors gradientLoadingColors;
  final GradientFadeColors gradientFadeColors;
}

class GradientLoadingColors {
  const GradientLoadingColors({
    required this.base,
    required this.highlight,
  });

  final Color base;
  final Color highlight;
}

class GradientFadeColors {
  const GradientFadeColors({
    required this.start,
    required this.end,
  });

  final Color start;
  final Color end;
}
