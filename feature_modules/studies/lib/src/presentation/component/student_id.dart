import 'package:core/components.dart' hide LMUCardTheme, LmuCardThemes, HolographicCard;
import 'package:flutter/material.dart';
import 'student_id/holographic_card.dart';
import 'student_id/themes/themes.dart';

class StudentId extends StatefulWidget {
  const StudentId({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String id;
  final String title;
  final String description;
  final void Function() onTap;

  @override
  State<StudentId> createState() => _StudentIdState();
}

class _StudentIdState extends State<StudentId> {
  LMUCardTheme _currentTheme = LmuCardThemes.greenTheme;

  void _onThemeSelected(LMUCardTheme theme) {
    setState(() {
      _currentTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HolographicCard(
      // User data
      name: widget.title,
      email: "john.doe@example.com",
      validUntil: "Valid until 30.06.2025",
      matrikelnr: "1234567890",
      lrzKennung: "jdoe123",
      braille: "⠇⠍⠥",

      // Card dimensions
      width: 350,
      height: 220,
      borderRadius: 15,
      borderWidth: 1,

      // Use current theme colors
      cardColor: _currentTheme.cardColor,
      textColor: _currentTheme.textColor,
      secondaryTextColor: _currentTheme.secondaryTextColor,
      logoColor: _currentTheme.logoColor,
      hologramColor: _currentTheme.hologramColor,
      borderCardColor: _currentTheme.borderColor,

      // Shader parameters from current theme
      shaderWaveFrequency: _currentTheme.shaderWaveFrequency,
      shaderPointerInfluence: _currentTheme.shaderPointerInfluence,
      shaderColorAmplitude: _currentTheme.shaderColorAmplitude,
      shaderBaseAlpha: _currentTheme.shaderBaseAlpha,

      // Theme selection
      currentTheme: _currentTheme,
      onThemeSelected: _onThemeSelected,

      // Assets
      logoAsset: 'packages/core/assets/holograms/legal_logo.svg',
      hologramAsset: 'packages/core/assets/holograms/LMU-Sigel.svg',
      hologramAsset2: 'packages/core/assets/holograms/LMUcard.svg',
      shaderpath: 'packages/core/assets/shader/holographic_shader.frag.glsl',

      // Feature toggles - use theme defaults
      enableGyro: LMUCardTheme.enableGyro,
      enableFlip: LMUCardTheme.enableFlip,
      enableShader: LMUCardTheme.enableShader,
      enableGestures: LMUCardTheme.enableGestures,
      enableHolographicEffects: LMUCardTheme.enableHolographicEffects,
      enableShadows: LMUCardTheme.enableShadows,

      // Movement settings from theme
      gestureSensitivity: LMUCardTheme.gestureSensitivity,
      gyroSensitivity: LMUCardTheme.gyroSensitivity,
      gyroSmoothing: LMUCardTheme.gyroSmoothing,
      hologramCenterMovement: LMUCardTheme.hologramCenterMovement,

      // Axis inversion
      invertGyroY: LMUCardTheme.invertGyroY,
      invertGyroX: LMUCardTheme.invertGyroX,
      invertGestureX: LMUCardTheme.invertGestureX,
      invertGestureY: LMUCardTheme.invertGestureY,

      // Shadow properties from theme
      ambientShadowOpacity: LMUCardTheme.ambientShadowOpacity,
      ambientShadowBlur: LMUCardTheme.ambientShadowBlur,
      ambientShadowYOffset: LMUCardTheme.ambientShadowYOffset,
      primaryShadowOpacity: LMUCardTheme.primaryShadowOpacity,
      midShadowOpacity: LMUCardTheme.midShadowOpacity,
      distantShadowOpacity: LMUCardTheme.distantShadowOpacity,
      shadowOffsetMultiplier: LMUCardTheme.shadowOffsetMultiplier,
      shadowIntensityMultiplier: LMUCardTheme.shadowIntensityMultiplier,

      // Logo properties from theme
      logoWidth: LMUCardTheme.logoWidth,
      logoHeight: LMUCardTheme.logoHeight,
      logoPosition: LMUCardTheme.logoPosition,

      // Hologram properties from theme
      hologram1Width: LMUCardTheme.hologram1Width,
      hologram1Height: LMUCardTheme.hologram1Height,
      hologram1Position: LMUCardTheme.hologram1Position,
      hologram2Width: LMUCardTheme.hologram2Width,
      hologram2Height: LMUCardTheme.hologram2Height,
      hologram2Position: LMUCardTheme.hologram2Position,

      // Callback functions
      onCardTap: () {
        print('Card tapped!');
      },
      onCardDoubleTap: () {
        print('Card double tapped!');
      },
      onMatrikelnrCopy: (matrikelnr) {
        LmuToast.show(
            context: context, message: "Matrikelnr copied: $matrikelnr");
      },
      onLrzKennungCopy: (lrzKennung) {
        LmuToast.show(
            context: context, message: "LRZ Kennung copied: $lrzKennung");
      },
    );
  }
}
