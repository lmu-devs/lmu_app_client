import 'dart:ui';

class MensaColors {
  const MensaColors({
    required this.textColors,
    required this.backgroundColors,
  });

  final MensaTextColors textColors;
  final MensaBackgroundColors backgroundColors;
}

class MensaTextColors {
  const MensaTextColors({
    required this.mensa,
    required this.stuBistro,
    required this.stuCafe,
    required this.stuLounge,
  });

  final Color mensa;
  final Color stuBistro;
  final Color stuCafe;
  final Color stuLounge;
}

class MensaBackgroundColors {
  const MensaBackgroundColors({
    required this.mensa,
    required this.stuBistro,
    required this.stuCafe,
    required this.stuLounge,
  });

  final Color mensa;
  final Color stuBistro;
  final Color stuCafe;
  final Color stuLounge;
}
