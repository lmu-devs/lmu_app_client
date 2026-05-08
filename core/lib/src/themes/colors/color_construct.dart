import 'dart:ui';

abstract class BaseColor {
  const BaseColor({
    required this.base,
    this.pressed,
    this.active,
    this.disabled,
  });

  final Color base;
  final Color? pressed;
  final Color? active;
  final Color? disabled;
}

class StrongColors extends BaseColor {
  const StrongColors({
    required super.base,
    required Color super.pressed,
    required Color super.active,
    required Color super.disabled,
  });
}

class MediumColors extends BaseColor {
  const MediumColors({
    required super.base,
    required Color super.pressed,
    required Color super.active,
    required Color super.disabled,
  });
}

class WeakColors extends BaseColor {
  const WeakColors({
    required super.base,
    required Color super.pressed,
    required Color super.active,
    required Color super.disabled,
  });
}

class NonInvertableColors extends BaseColor {
  const NonInvertableColors({
    required super.base,
    required Color super.pressed,
    required Color super.disabled,
    required Color super.active,
  });
}

class FlippedColors extends BaseColor {
  const FlippedColors({
    required super.base,
    required Color super.pressed,
    required Color super.disabled,
  });
}
