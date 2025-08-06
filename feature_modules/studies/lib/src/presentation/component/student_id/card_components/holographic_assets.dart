import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HolographicAssets extends StatelessWidget {
  final String? hologramAsset;
  final String? hologramAsset2;
  final Color hologramColor;
  final bool enableHolographicEffects;
  final double combinedX;
  final double combinedY;
  final double hologram1Width;
  final double hologram1Height;
  final Offset hologram1Position;
  final double hologram2Width;
  final double hologram2Height;
  final Offset hologram2Position;

  const HolographicAssets({
    super.key,
    this.hologramAsset,
    this.hologramAsset2,
    required this.hologramColor,
    required this.enableHolographicEffects,
    required this.combinedX,
    required this.combinedY,
    required this.hologram1Width,
    required this.hologram1Height,
    required this.hologram1Position,
    required this.hologram2Width,
    required this.hologram2Height,
    required this.hologram2Position,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableHolographicEffects) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        // First hologram
        if (hologramAsset != null)
          Positioned(
            bottom: hologram1Position.dy == -1 ? 0 : hologram1Position.dy,
            right: hologram1Position.dx == -1 ? 0 : null,
            left: hologram1Position.dx >= 0 ? hologram1Position.dx : null,
            top: hologram1Position.dy >= 0 ? hologram1Position.dy : null,
            child: Opacity(
              opacity:
                  enableHolographicEffects
                      ? (0.8 - ((combinedY).abs() * 2)).clamp(0.0, 1.0)
                      : 0.8,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      hologramColor.withOpacity(0),
                      hologramColor.withOpacity(1),
                      hologramColor.withOpacity(0),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: SvgPicture.asset(
                  hologramAsset!,
                  width: hologram1Width,
                  height: hologram1Height,
                  colorFilter: ColorFilter.mode(hologramColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),

        // Second hologram
        if (hologramAsset2 != null)
          Positioned(
            bottom: hologram2Position.dy == -1 ? 0 : hologram2Position.dy,
            left: hologram2Position.dx >= 0 ? hologram2Position.dx : 0,
            right: hologram2Position.dx == -1 ? 0 : null,
            top: hologram2Position.dy >= 0 ? hologram2Position.dy : null,
            child: Opacity(
              opacity:
                  enableHolographicEffects
                      ? ((combinedX) > 0.15
                          ? (((combinedX) - 0.15) * 5).clamp(0.0, 0.9)
                          : 0.0)
                      : 0.5,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      hologramColor.withOpacity(0.2),
                      hologramColor.withOpacity(0.4),
                      hologramColor.withOpacity(0.2),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: SvgPicture.asset(
                  hologramAsset2!,
                  width: hologram2Width,
                  height: hologram2Height,
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
