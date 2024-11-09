import 'dart:ui';

class GradientColors {
  const GradientColors({
    required this.gradientLoadingColors,
  });

  final GradientLoadingColors gradientLoadingColors;
}

class GradientLoadingColors {
  const GradientLoadingColors({
    required this.base,
    required this.highlight,
  });

  final Color base;
  final Color highlight;
}
