import 'dart:ui';

class UniversityColors {
  const UniversityColors({
    required this.textColors,
  });

  final UniversityTextColors textColors;
}

class UniversityTextColors {
  const UniversityTextColors(
    this.lmuColor,
    this.tumColor,
    this.hmColor,
  );

  final Color lmuColor;
  final Color tumColor;
  final Color hmColor;
}
