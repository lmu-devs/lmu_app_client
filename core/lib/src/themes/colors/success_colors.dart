import 'color_construct.dart';

class SuccessColors {
  const SuccessColors({
    required this.textColors,
    // required this.backgroundColors,
  });

  final SuccessTextColors textColors;
  // final SuccessBackgroundColors backgroundColors;
}

class SuccessTextColors {
  const SuccessTextColors({
    required this.strongColors,
  });

  final StrongColors strongColors;
}

// class SuccessBackgroundColors {
//   const SuccessBackgroundColors({
//     required this.mediumColors,
//     required this.strongColors,
//     required this.nonInvertableColors,
//   });
//   final MediumColors mediumColors;
//   final StrongColors strongColors;
//   final NonInvertableColors nonInvertableColors;
// }
