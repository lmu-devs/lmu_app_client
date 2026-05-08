import 'package:flutter/material.dart';

import '../../core.dart';

enum FadingDirection {
  none,
  top,
  bottom,
  both,
}

class ListFadingShader extends StatelessWidget {
  const ListFadingShader({
    super.key,
    this.color,
    required this.child,
    this.direction = FadingDirection.both,
  });

  final Color? color;
  final Widget child;
  final FadingDirection direction;

  @override
  Widget build(BuildContext context) {
    if (direction == FadingDirection.none) {
      return child;
    }

    final defaultColor = context.colors.neutralColors.backgroundColors.base;
    final gradientColor = color ?? defaultColor;

    Color colorWithOpacity(Color color, double opacity) {
      return color.withAlpha((255.0 * opacity).round());
    }

    List<Color> colors;
    List<double> stops;

    switch (direction) {
      case FadingDirection.top:
        colors = [
          gradientColor,
          colorWithOpacity(gradientColor, 0.8),
          colorWithOpacity(gradientColor, 0.6),
          colorWithOpacity(gradientColor, 0.4),
          colorWithOpacity(gradientColor, 0.2),
          Colors.transparent,
        ];
        stops = [0.0, 0.01, 0.03, 0.05, 0.07, 0.08];
        break;

      case FadingDirection.bottom:
        colors = [
          Colors.transparent,
          colorWithOpacity(gradientColor, 0.2),
          colorWithOpacity(gradientColor, 0.4),
          colorWithOpacity(gradientColor, 0.6),
          colorWithOpacity(gradientColor, 0.8),
          gradientColor,
        ];
        stops = [0.92, 0.93, 0.95, 0.97, 0.99, 1.0];
        break;

      case FadingDirection.both:
      default:
        colors = [
          gradientColor,
          colorWithOpacity(gradientColor, 0.8),
          colorWithOpacity(gradientColor, 0.6),
          colorWithOpacity(gradientColor, 0.4),
          colorWithOpacity(gradientColor, 0.2),
          Colors.transparent,
          Colors.transparent,
          colorWithOpacity(gradientColor, 0.2),
          colorWithOpacity(gradientColor, 0.4),
          colorWithOpacity(gradientColor, 0.6),
          colorWithOpacity(gradientColor, 0.8),
          gradientColor,
        ];
        stops = [
          0.0,
          0.01,
          0.03,
          0.05,
          0.07,
          0.08,
          0.92,
          0.93,
          0.95,
          0.97,
          0.99,
          1.0,
        ];
        break;
    }

    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: stops,
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: child,
    );
  }
}