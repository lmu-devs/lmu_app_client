import 'color_construct.dart';

class BrandColors {
  const BrandColors({
    required this.textColors,
    required this.backgroundColors,
  });

  final BrandTextColors textColors;
  final BrandBackgroundColors backgroundColors;
}

class BrandTextColors {
  const BrandTextColors({
    required this.strongColors,
    required this.nonInvertableColors,
  });

  final StrongColors strongColors;
  final NonInvertableColors nonInvertableColors;
}

class BrandBackgroundColors {
  const BrandBackgroundColors({
    required this.mediumColors,
    required this.strongColors,
    required this.nonInvertableColors,
  });
  final MediumColors mediumColors;
  final StrongColors strongColors;
  final NonInvertableColors nonInvertableColors;
}
