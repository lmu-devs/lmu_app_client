import 'dart:ui';

class CustomColors {
  const CustomColors({
    required this.textColors,
    required this.backgroundColors,
  });

  final CustomTextColors textColors;
  final CustomBackgroundColors backgroundColors;
}

class CustomTextColors {
  const CustomTextColors({
    required this.mensa,
    required this.stuBistro,
    required this.stuCafe,
    required this.stuLounge,
    required this.cinema,
    required this.building,
    required this.library,
  });

  final Color mensa;
  final Color stuBistro;
  final Color stuCafe;
  final Color stuLounge;
  final Color cinema;
  final Color building;
  final Color library;
}

class CustomBackgroundColors {
  const CustomBackgroundColors({
    required this.mensa,
    required this.stuBistro,
    required this.stuCafe,
    required this.stuLounge,
    required this.cinema,
    required this.building,
    required this.library,
  });

  final Color mensa;
  final Color stuBistro;
  final Color stuCafe;
  final Color stuLounge;
  final Color cinema;
  final Color building;
  final Color library;
}
