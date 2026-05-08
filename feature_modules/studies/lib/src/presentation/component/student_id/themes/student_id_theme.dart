import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class StudentIdTheme {
  const StudentIdTheme({
    required this.id,
    required this.name,
    required this.cardColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.logoColor,
    required this.hologramColor,
    required this.borderColor,
    required this.shaderWaveFrequency,
    required this.shaderPointerInfluence,
    required this.shaderColorAmplitude,
    required this.shaderBaseAlpha,
  });

  final String id;
  final String name;
  final Color cardColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color logoColor;
  final Color hologramColor;
  final Color borderColor;
  final double shaderWaveFrequency;
  final double shaderPointerInfluence;
  final double shaderColorAmplitude;
  final double shaderBaseAlpha;
}

class StudentIdThemes {
  StudentIdThemes(this._context);

  final BuildContext _context;

  static const String defaultThemeId = 'forest';

  StudentIdTheme get holographicTheme => const StudentIdTheme(
        id: 'prismatic',
        name: 'Prismatic',
        cardColor: Color.fromARGB(255, 162, 162, 162),
        textColor: Colors.black,
        secondaryTextColor: Colors.black54,
        logoColor: Colors.black,
        hologramColor: Colors.white,
        borderColor: Colors.white24,
        shaderWaveFrequency: 4.0,
        shaderPointerInfluence: 7.0,
        shaderColorAmplitude: 0.05,
        shaderBaseAlpha: 0.05,
      );

  StudentIdTheme get darkTheme => StudentIdTheme(
        id: 'midnight',
        name: 'Midnight',
        cardColor: const Color.fromARGB(255, 0, 0, 0),
        textColor: _context.colors.neutralColors.textColors.strongColors.base,
        secondaryTextColor: _context.colors.neutralColors.textColors.mediumColors.base,
        logoColor: _context.colors.neutralColors.textColors.mediumColors.base,
        hologramColor: Colors.white,
        borderColor: Colors.white24,
        shaderWaveFrequency: 4.0,
        shaderPointerInfluence: 10.0,
        shaderColorAmplitude: 0.04,
        shaderBaseAlpha: 0.05,
      );

  StudentIdTheme get purpleTheme => const StudentIdTheme(
        id: 'pearl',
        name: 'Pearl',
        cardColor: Color.fromARGB(167, 93, 0, 200),
        textColor: Colors.white,
        secondaryTextColor: Colors.white70,
        logoColor: Colors.white,
        hologramColor: Colors.white,
        borderColor: Colors.white24,
        shaderWaveFrequency: 5.0,
        shaderPointerInfluence: 10.0,
        shaderColorAmplitude: 0.1,
        shaderBaseAlpha: 0.03,
      );

  StudentIdTheme get greenTheme => const StudentIdTheme(
        id: 'forest',
        name: 'Forest',
        cardColor: Color.fromARGB(255, 12, 87, 0),
        textColor: Colors.white,
        secondaryTextColor: Colors.white70,
        logoColor: Colors.white,
        hologramColor: Color.fromARGB(206, 255, 255, 255),
        borderColor: Colors.white24,
        shaderWaveFrequency: 5.0,
        shaderPointerInfluence: 10.0,
        shaderColorAmplitude: 0.03,
        shaderBaseAlpha: 0.03,
      );

  StudentIdTheme get blueTheme => const StudentIdTheme(
        id: 'ocean',
        name: 'Ocean',
        cardColor: Color.fromARGB(255, 0, 36, 104),
        textColor: Colors.white,
        secondaryTextColor: Color.fromARGB(255, 208, 208, 208),
        logoColor: Colors.white,
        hologramColor: Colors.white,
        borderColor: Colors.white24,
        shaderWaveFrequency: 5.0,
        shaderPointerInfluence: 10.0,
        shaderColorAmplitude: 0.08,
        shaderBaseAlpha: 0.03,
      );

  StudentIdTheme get redTheme => const StudentIdTheme(
        id: 'crimson',
        name: 'Crimson',
        cardColor: Color.fromARGB(255, 128, 0, 0),
        textColor: Colors.white,
        secondaryTextColor: Color.fromARGB(255, 208, 208, 208),
        logoColor: Colors.white,
        hologramColor: Colors.white,
        borderColor: Colors.white24,
        shaderWaveFrequency: 5.0,
        shaderPointerInfluence: 10.0,
        shaderColorAmplitude: 0.03,
        shaderBaseAlpha: 0.03,
      );

  List<StudentIdTheme> get allThemes => [
        holographicTheme,
        darkTheme,
        purpleTheme,
        greenTheme,
        blueTheme,
        redTheme,
      ];

  StudentIdTheme getById(String id) {
    return allThemes.firstWhere(
      (theme) => theme.id == id,
      orElse: () => greenTheme,
    );
  }
}
