import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuCardThemes {
  final BuildContext context;

  LmuCardThemes(this.context);

  LMUCardTheme get holographicTheme => LMUCardTheme(
        cardColor: Color.fromARGB(255, 162, 162, 162),
        textColor: Colors.black,
        secondaryTextColor: Colors.black54,
        logoColor: Colors.black,
        hologramColor: Colors.white,
        borderColor: Colors.white24,
        name: 'Prismatic',

        // Shader parameters
        shaderWaveFrequency: 4.0,
        shaderPointerInfluence: 7.0,
        shaderColorAmplitude: 0.05,
        shaderBaseAlpha: 0.05,
      );

  // LMU Dark theme
  LMUCardTheme get darkTheme => LMUCardTheme(
    cardColor: Color.fromARGB(255, 0, 0, 0),
    textColor: context.colors.neutralColors.textColors.strongColors.base,
    secondaryTextColor: context.colors.neutralColors.textColors.mediumColors.base,
    logoColor: context.colors.neutralColors.textColors.mediumColors.base,
    hologramColor: Colors.white,
        borderColor: Colors.white24,
    name: 'Midnight',

    // Shader parameters
    shaderWaveFrequency: 4.0,
    shaderPointerInfluence: 10.0,
    shaderColorAmplitude: 0.04,
    shaderBaseAlpha: 0.05,
  );

  // LMU White theme
  static const purpleTheme = LMUCardTheme(
    cardColor: Color.fromARGB(167, 93, 0, 200),
    textColor: Colors.white,
    secondaryTextColor: Colors.white70,
    logoColor: Colors.white,
    hologramColor: Colors.white,
        borderColor: Colors.white24,
    name: 'Pearl',

    // Shader parameters
    shaderWaveFrequency: 5.0,
    shaderPointerInfluence: 10.0,
    shaderColorAmplitude: 0.1,
    shaderBaseAlpha: 0.03,
  );

  // LMU Green theme
  static const greenTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 12, 87, 0),
    textColor: Colors.white,
    secondaryTextColor: Colors.white70,
    logoColor: Colors.white,
    hologramColor: Color.fromARGB(206, 255, 255, 255),
        borderColor: Colors.white24,
    name: 'Forest',

    // Shader parameters
    shaderWaveFrequency: 5.0,
    shaderPointerInfluence: 10.0,
    shaderColorAmplitude: 0.03,
    shaderBaseAlpha: 0.03,
  );

  // LMU Blue theme
  static const blueTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 0, 36, 104),
    textColor: Colors.white,
    secondaryTextColor: Color.fromARGB(255, 208, 208, 208),
    logoColor: Colors.white,
    hologramColor: Colors.white,
        borderColor: Colors.white24,
    name: 'Ocean',

    // Shader parameters
    shaderWaveFrequency: 5.0,
    shaderPointerInfluence: 10.0,
    shaderColorAmplitude: 0.08,
    shaderBaseAlpha: 0.03,
  );

  // LMU Red theme
  static const redTheme = LMUCardTheme(
    cardColor: Color.fromARGB(255, 128, 0, 0),
    textColor: Colors.white,
    secondaryTextColor: Color.fromARGB(255, 208, 208, 208),
    logoColor: Colors.white,
    hologramColor: Colors.white,
        borderColor: Colors.white24,
    name: 'Crimson',

    // Shader parameters
    shaderWaveFrequency: 5.0,
    shaderPointerInfluence: 10.0,
    shaderColorAmplitude: 0.03,
    shaderBaseAlpha: 0.03,
  );

  // List of all available themes
  List<LMUCardTheme> get allThemes => [
    holographicTheme,
    darkTheme,
    purpleTheme,
    greenTheme,
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

  // Shader parameters
  final double shaderWaveFrequency;
  final double shaderPointerInfluence;
  final double shaderColorAmplitude;
  final double shaderBaseAlpha;

  // Shadow configuration - keeping these constant across themes
  static const double ambientShadowOpacity = 0.2;
  static const double ambientShadowBlur = 20.0;
  static const double ambientShadowYOffset = 3.0;
  static const double primaryShadowOpacity = 0.1;
  static const double midShadowOpacity = 0.05;
  static const double distantShadowOpacity = 0.02;

  // Movement settings - keeping these constant across themes
  static const double gestureSensitivity = 0.4;
  static const double gyroSensitivity = 0.7;
  static const double gyroSmoothing = 0.85;
  static const double hologramCenterMovement = 0.2;
  static const double shadowOffsetMultiplier = 10.0;
  static const double shadowIntensityMultiplier = 1;

  // Feature toggles with defaults
  static const bool enableFlip = true;
  static const bool enableGyro = true;
  static const bool enableGestures = true;
  static const bool enableShader = true;
  static const bool enableHolographicEffects = true;
  static const bool enableShadows = true;
  static const bool invertGyroY = true;
  static const bool invertGyroX = true;
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
  static const Offset hologram2Position = Offset(0, -25);

  const LMUCardTheme({
    required this.cardColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.logoColor,
    required this.hologramColor,
    required this.borderColor,
    required this.name,
    required this.shaderWaveFrequency,
    required this.shaderPointerInfluence,
    required this.shaderColorAmplitude,
    required this.shaderBaseAlpha,
  });
}
