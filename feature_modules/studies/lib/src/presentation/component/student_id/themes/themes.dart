import 'package:flutter/material.dart';

class LmuCardThemes {
  // LMU White theme
  static const whiteTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 162, 162, 162),
    textColor: Colors.black,
    secondaryTextColor: Colors.black54,
    logoColor: Colors.black,
    hologramColor: Colors.white,
    borderColor: Color.fromARGB(255, 255, 255, 255),
    name: 'Holo',
  );

  // LMU Green theme
  static const greenTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 10, 78, 0),
    textColor: Colors.white,
    secondaryTextColor: Colors.white70,
    logoColor: Colors.white,
    hologramColor: Color.fromARGB(206, 255, 255, 255),
    borderColor: Color.fromARGB(255, 10, 78, 0),
    name: 'Green',
  );

  // LMU Dark theme
  static const darkTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 10, 10, 10),
    textColor: Colors.white,
    secondaryTextColor: Color.fromARGB(255, 208, 208, 208),
    logoColor: Colors.white,
    hologramColor: Colors.white,
    borderColor: Color.fromARGB(255, 10, 10, 10),
    name: 'Dark',
  );

  // LMU Blue theme
  static const blueTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 0, 70, 128),
    textColor: Colors.white,
    secondaryTextColor: Color.fromARGB(255, 208, 208, 208),
    logoColor: Colors.white,
    hologramColor: Colors.white,
    borderColor: Color.fromARGB(255, 0, 70, 128),
    name: 'Blue',
  );

  // LMU Red theme
  static const redTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 128, 0, 0),
    textColor: Colors.white,
    secondaryTextColor: Color.fromARGB(255, 208, 208, 208),
    logoColor: Colors.white,
    hologramColor: Colors.white,
    borderColor: Color.fromARGB(255, 128, 0, 0),
    name: 'Red',
  );

  // List of all available themes
  static const List<LMUCardTheme> allThemes = [
    whiteTheme,
    greenTheme,
    darkTheme,
    blueTheme,
    redTheme,
  ];
}

class LMUCardTheme {
  final Color cardColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color logoColor;
  final Color hologramColor;
  final Color borderColor;
  final String name;

  // Shadow configuration - keeping these constant across themes
  static const double ambientShadowOpacity = 0.2;
  static const double ambientShadowBlur = 20.0;
  static const double ambientShadowYOffset = 3.0;
  static const double primaryShadowOpacity = 0.1;
  static const double midShadowOpacity = 0.05;
  static const double distantShadowOpacity = 0.02;

  // Movement settings - keeping these constant across themes
  static const double gestureSensitivity = 0.5;
  static const double gyroSensitivity = 0.5;
  static const double gyroSmoothing = 0.85;
  static const double hologramCenterMovement = 0.3;
  static const double shadowOffsetMultiplier = 10.0;
  static const double shadowIntensityMultiplier = 1;

  // Feature toggles with defaults
  static const bool enableFlip = true;
  static const bool enableGyro = true;
  static const bool enableGestures = true;
  static const bool enableShader = true;
  static const bool enableHolographicEffects = true;
  static const bool enableShadows = true;
  static const bool invertGyroY = false;
  static const bool invertGyroX = false;
  static const bool invertGestureX = false;
  static const bool invertGestureY = false;

  // Logo properties
  static const double logoWidth = 60;
  static const double logoHeight = 40;
  static const Offset logoPosition = Offset(20, 20);

  // Hologram properties
  static const double hologram1Width = 150;
  static const double hologram1Height = 150;
  static const Offset hologram1Position = Offset(
    -1,
    -1,
  ); // -1 means bottom right
  static const double hologram2Width = 400; // Use width of the card
  static const double hologram2Height = 100;
  static const Offset hologram2Position = Offset(-1, -0.5);

  // Shader parameters
  static const double shaderWaveFrequency = 5.0;
  static const double shaderPointerInfluence = 5.0;
  static const double shaderColorAmplitude = 0.03;
  static const double shaderBaseAlpha = 0.5;

  const LMUCardTheme({
    required this.cardColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.logoColor,
    required this.hologramColor,
    required this.borderColor,
    required this.name,
  });
}
