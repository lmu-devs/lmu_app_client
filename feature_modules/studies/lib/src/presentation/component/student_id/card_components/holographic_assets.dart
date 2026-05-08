import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HolographicAssets extends StatelessWidget {
  const HolographicAssets({
    super.key,
    required this.hologramColor,
    required this.combinedX,
    required this.combinedY,
  });

  final Color hologramColor;
  final double combinedX;
  final double combinedY;

  static const _hologramAsset1 = 'packages/core/assets/holograms/LMU-Sigel.svg';
  static const _hologramAsset2 = 'packages/core/assets/holograms/LMUcard.svg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // LMU Sigel — bottom right, visible when not tilted vertically
        Positioned(
          bottom: 0,
          right: 0,
          child: Opacity(
            opacity: (0.8 - (combinedY.abs() * 2)).clamp(0.0, 1.0),
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
                _hologramAsset1,
                width: 150,
                height: 150,
                colorFilter: ColorFilter.mode(hologramColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),

        // LMUcard text — bottom, visible when tilting right
        Positioned(
          bottom: -25,
          left: 0,
          child: Opacity(
            opacity: combinedX > 0.15
                ? ((combinedX - 0.15) * 5).clamp(0.0, 0.9)
                : 0.0,
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
                _hologramAsset2,
                width: 400,
                height: 100,
                fit: BoxFit.fitWidth,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
