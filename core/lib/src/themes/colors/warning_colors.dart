import 'color_construct.dart';

class WarningColors {
  const WarningColors({
    required this.textColors,
    // required this.backgroundColors,
  });

  final WarningTextColors textColors;
  // final WarningBackgroundColors backgroundColors;
}

class WarningTextColors {
  const WarningTextColors({
    required this.strongColors,
  });

  final StrongColors strongColors;
}

// class WarningBackgroundColors {
//   const WarningBackgroundColors({
//     required this.mediumColors,
//     required this.strongColors,
//     required this.nonInvertableColors,
//   });
//   final MediumColors mediumColors;
//   final StrongColors strongColors;
//   final NonInvertableColors nonInvertableColors;
// }
