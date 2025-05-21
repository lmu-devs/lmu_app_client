import 'dart:math' as math;
import 'package:flutter/material.dart';

class HolographicWatermarks extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final String matrikelnr;
  final Color hologramColor;
  final bool enableHolographicEffects;
  final double combinedX;
  final double combinedY;

  const HolographicWatermarks({
    super.key,
    required this.width,
    required this.height,
    required this.name,
    required this.matrikelnr,
    required this.hologramColor,
    required this.enableHolographicEffects,
    required this.combinedX,
    required this.combinedY,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableHolographicEffects) {
      return const SizedBox.shrink();
    }

    final List<Widget> watermarks = [];

    // Define grid properties
    const int rows = 3;
    const int cols = 20;
    final double cellWidth = width / cols;
    final double cellHeight = height / rows;
    const double rotation = math.pi / 2;

    // Calculate opacity based on left tilt with shimmer effect
    final tiltOpacity =
        combinedX < -0.15 ? ((-combinedX - 0.15) * 5).clamp(0.0, 0.9) : 0.0;

    // Create grid of watermarks
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        // Base position
        final x = col * cellWidth;
        final y = row * cellHeight;
        final isName = (row + col) % 2 == 0;

        // Parallax offset based on tilt
        final parallaxX =
            combinedX *
            30 *
            (col / cols); // Horizontal parallax increases with column
        final parallaxY =
            combinedY *
            20 *
            (row / rows); // Vertical parallax increases with row

        // Shimmer effect - varies with position and tilt
        final shimmerPhase = (col / cols + row / rows) * math.pi;
        final shimmerIntensity =
            (math.sin(shimmerPhase + combinedX * 5) + 1) / 2;

        watermarks.add(
          Positioned(
            left: x + (cellWidth - 100) / 2 + parallaxX,
            top: y + (cellHeight - 20) / 2 + parallaxY,
            child: Transform.rotate(
              angle: rotation,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment(
                      -0.5 + combinedX, // Gradient moves with tilt
                      -0.5 + combinedY,
                    ),
                    end: Alignment(1.5 + combinedX, 1.5 + combinedY),
                    colors: [
                      hologramColor.withOpacity(
                        (tiltOpacity * 0.4 * (1 + shimmerIntensity * 0.3))
                            .clamp(0.0, 0.9),
                      ),
                      hologramColor.withOpacity(
                        (tiltOpacity * 0.6 * (1 + shimmerIntensity * 0.5))
                            .clamp(0.0, 0.9),
                      ),
                      hologramColor.withOpacity(
                        (tiltOpacity * 0.4 * (1 + shimmerIntensity * 0.3))
                            .clamp(0.0, 0.9),
                      ),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  (isName ? name : matrikelnr).toUpperCase(),
                  style: TextStyle(
                    color: hologramColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Stack(children: watermarks);
  }
}
