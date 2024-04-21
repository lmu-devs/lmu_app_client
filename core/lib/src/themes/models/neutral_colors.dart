import 'dart:ui';

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

class BackgroundColors implements BaseColor {
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

  @override
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

class WeakColors implements BaseColor {
  const WeakColors({
    required this.base,
    required this.pressed,
    required this.disabled,
  });

  @override
  final Color base;
  final Color pressed;
  final Color disabled;
}

class MediumColors implements BaseColor {
  const MediumColors({
    required this.base,
    required this.pressed,
    required this.disabled,
  });

  @override
  final Color base;
  final Color pressed;
  final Color disabled;
}

class StrongColors implements BaseColor {
  const StrongColors({
    required this.base,
    required this.pressed,
    required this.disabled,
  });

  @override
  final Color base;
  final Color pressed;
  final Color disabled;
}

class NonInvertableColors implements BaseColor {
  const NonInvertableColors({
    required this.base,
    required this.pressed,
    required this.disabled,
    required this.decoration,
  });

  @override
  final Color base;
  final Color pressed;
  final Color disabled;
  final Color decoration;
}

class FlippedColors implements BaseColor {
  const FlippedColors({
    required this.base,
    required this.pressed,
    required this.disabled,
  });

  @override
  final Color base;
  final Color pressed;
  final Color disabled;
}

abstract class BaseColor {
  BaseColor({
    required this.base,
  });

  final Color base;
}
