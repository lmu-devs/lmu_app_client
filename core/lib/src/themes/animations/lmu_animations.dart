import 'package:sprung/sprung.dart';

class LmuAnimations {
  /// Fast and Smooth spring animation 400ms
  static final fastSmooth = Sprung.custom(
    stiffness: 200.0,
    damping: 30,
    mass: 1.0,
  );

  /// Fast and Smooth spring animation 500ms
  static final slowSmooth = Sprung.custom(
    stiffness: 115.0,
    damping: 24,
    mass: 1.0,
  );

  /// Slow spring animation 800ms
  static final gentle = Sprung.custom(
    stiffness: 100,
    damping: 15,
    mass: 1.0,
  );

  /// Moves fast with slight rebounce spring animation 500ms
  static final quick = Sprung.custom(
    stiffness: 327,
    damping: 24,
    mass: 1.0,
  );
  static final test = Sprung.custom(
    stiffness: 300,
    damping: 20,
    mass: 1.0,
  );
}
