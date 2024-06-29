import 'color_construct.dart';

class DangerColors {
  const DangerColors({
    required this.textColors,
    required this.backgroundColors,
  });

  final DangerTextColors textColors;
  final DangerBackgroundColors backgroundColors;
}

class DangerTextColors {
  const DangerTextColors({
    required this.strongColors,
  });

  final StrongColors strongColors;
}

class DangerBackgroundColors {
  const DangerBackgroundColors({
    required this.weakColors,
    required this.strongColors,
  });
  final WeakColors weakColors;
  final StrongColors strongColors;
}
