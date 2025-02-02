import 'dart:ui';

class UniversityColors {
  const UniversityColors({
    required this.textColors,
    required this.backgroundColors,
  });

  final UniversityTextColors textColors;
  final UniversityBackgroundColors backgroundColors;
}

class UniversityTextColors {
  const UniversityTextColors({
    required this.lmuColor,
    required this.tumColor,
    required this.hmColor,
  });

  final Color lmuColor;
  final Color tumColor;
  final Color hmColor;
}

class UniversityBackgroundColors {
  const UniversityBackgroundColors({
    required this.lmuColor,
    required this.tumColor,
    required this.hmColor,
  });

  final Color lmuColor;
  final Color tumColor;
  final Color hmColor;
}
