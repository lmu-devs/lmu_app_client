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
    required Color base,
    required Color pressed,
    required Color active,
    required Color disabled,
  }) : super(
          base: base,
          pressed: pressed,
          active: active,
          disabled: disabled,
        );
}

class MediumColors extends BaseColor {
  const MediumColors({
    required Color base,
    required Color pressed,
    required Color active,
    required Color disabled,
  }) : super(
          base: base,
          pressed: pressed,
          active: active,
          disabled: disabled,
        );
}

class WeakColors extends BaseColor {
  const WeakColors({
    required Color base,
    required Color pressed,
    required Color active,
    required Color disabled,
  }) : super(
          base: base,
          pressed: pressed,
          active: active,
          disabled: disabled,
        );
}

class NonInvertableColors extends BaseColor {


  const NonInvertableColors({
    required Color base,
    required Color pressed,
    required Color disabled,
  }) : super(
          base: base,
          pressed: pressed,
          disabled: disabled,
        );

}

class FlippedColors extends BaseColor {
  const FlippedColors({
    required Color base,
    required Color pressed,
    required Color disabled,
  }) : super(
          base: base,
          pressed: pressed,
          disabled: disabled,
        );
}
