import 'dart:ui';
import 'color_construct.dart';

class NeutralColors {
  const NeutralColors({
    required this.textColors,
    required this.backgroundColors,
    required this.borderColors,
  });

  final TextColors textColors;
  final BackgroundColors backgroundColors;
  final BorderColors borderColors;
}

class TextColors {
  const TextColors({
    required this.weakColors,
    required this.mediumColors,
    required this.strongColors,
    required this.nonInvertableColors,
    required this.flippedColors,
  });

  final WeakColors weakColors;
  final MediumColors mediumColors;
  final StrongColors strongColors;
  final NonInvertableColors nonInvertableColors;
  final FlippedColors flippedColors;
}

class BackgroundColors {
  const BackgroundColors({
    required this.base,
    required this.tile,
    required this.pure,
    required this.weakColors,
    required this.mediumColors,
    required this.strongColors,
    required this.nonInvertableColors,
    required this.flippedColors,
  });

  final Color base;
  final Color tile;
  final Color pure;

  final WeakColors weakColors;
  final MediumColors mediumColors;
  final StrongColors strongColors;
  final NonInvertableColors nonInvertableColors;
  final FlippedColors flippedColors;
}

class BorderColors {
  const BorderColors({
    required this.seperatorLight,
    required this.inputStroke,
    required this.cutout,
    required this.seperatorDark,
  });

  final Color seperatorLight;
  final Color inputStroke;
  final Color cutout;
  final Color seperatorDark;
}



