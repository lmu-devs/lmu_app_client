import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'student_id/holographic_card.dart';
import 'student_id/themes/themes.dart';

class StudentId extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return HolographicCard(
      // User data
      name: title,
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

      // Use theme colors consistently
      cardColor: LmuCardThemes.greenTheme.cardColor,
      textColor: LmuCardThemes.greenTheme.textColor,
      secondaryTextColor: LmuCardThemes.greenTheme.secondaryTextColor,
      logoColor: LmuCardThemes.greenTheme.logoColor,
      hologramColor: LmuCardThemes.greenTheme.hologramColor,
      borderCardColor:
          LmuCardThemes.greenTheme.borderColor, // Use theme border color

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

      // Shader parameters from theme
      shaderWaveFrequency: LMUCardTheme.shaderWaveFrequency,
      shaderPointerInfluence: LMUCardTheme.shaderPointerInfluence,
      shaderColorAmplitude: LMUCardTheme.shaderColorAmplitude,
      shaderBaseAlpha: LMUCardTheme.shaderBaseAlpha,

      // Callback functions
      onCardTap: () {
        // Handle card tap
        print('Card tapped!');
      },
      onCardDoubleTap: () {
        // Handle double tap (triggers flip)
        print('Card double tapped!');
      },
      onMatrikelnrCopy: (matrikelnr) {
        // Show success message
        LmuToast.show(
            context: context, message: "Matrikelnr copied: $matrikelnr");
      },
      onLrzKennungCopy: (lrzKennung) {
        // Show success message
        LmuToast.show(
            context: context, message: "LRZ Kennung copied: $lrzKennung");
      },
    );
  }
}
