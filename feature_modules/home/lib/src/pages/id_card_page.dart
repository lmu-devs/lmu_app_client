import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdCardPage extends StatelessWidget {
  const IdCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: "Student ID",
        leadingAction: LeadingAction.back,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: LmuSizes.size_32,
            left: LmuSizes.size_16,
            right: LmuSizes.size_16,
            bottom: LmuSizes.size_16,
          ),
          child: HolographicCard(
            // User data
            name: "Raphael Wennmacher",
            email: "r.wennmacher@campus.lmu.de",
            validUntil: "Valid until 2026-12-31",
            matrikelnr: "1234567890",
            lrzKennung: "lrw29f",
            braille: "⠇⠍⠥",

            // Card dimensions
            width: 350,
            height: 220,
            borderRadius: 20,
            borderWidth: 1,

            // Use theme colors consistently
            cardColor: LmuCardThemes.whiteTheme.cardColor,
            textColor: LmuCardThemes.whiteTheme.textColor,
            secondaryTextColor: LmuCardThemes.whiteTheme.secondaryTextColor,
            logoColor: LmuCardThemes.whiteTheme.logoColor,
            hologramColor: LmuCardThemes.whiteTheme.hologramColor,
            borderCardColor:
                LmuCardThemes.whiteTheme.borderColor, // Use theme border color

            // Assets
            logoAsset: 'packages/core/assets/holograms/legal_logo.svg',
            hologramAsset: 'packages/core/assets/holograms/LMU-Sigel.svg',
            hologramAsset2: 'packages/core/assets/holograms/LMUcard.svg',
            shaderpath:
                'packages/core/assets/shader/holographic_shader.frag.glsl',

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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Matrikelnr copied: $matrikelnr')),
              );
            },
            onLrzKennungCopy: (lrzKennung) {
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('LRZ Kennung copied: $lrzKennung')),
              );
            },
          ),
        ),
      ),
    );
  }
}
