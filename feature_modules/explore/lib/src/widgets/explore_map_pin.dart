import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class ExploreMapPin extends StatelessWidget {
  const ExploreMapPin({super.key, required this.pinColor, required this.icon});

  final Color pinColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return RepaintBoundary(
      child: CustomPaint(
        painter: _MarkerPainter(
          contentColor: pinColor,
          borderColor: colors.neutralColors.borderColors.iconOutline,
        ),
        child: Align(
          alignment: const Alignment(0, -0.7),
          child: LmuIcon(
            icon: icon,
            size: LmuIconSizes.medium,
            color: colors.neutralColors.textColors.flippedColors.base,
          ),
        ),
      ),
    );
  }
}

class _MarkerPainter extends CustomPainter {
  const _MarkerPainter({
    required this.contentColor,
    required this.borderColor,
  });

  final Color contentColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final shapePath = Path();
    shapePath.moveTo(48, 24.4717);
    shapePath.cubicTo(48, 31.095, 45.3385, 37.1292, 41, 41.4717);
    shapePath.cubicTo(38.4349, 44.0392, 32.9375, 48.1469, 28.8657, 51.0803);
    shapePath.cubicTo(25.9009, 53.2161, 21.9194, 53.1999, 18.9705, 51.0425);
    shapePath.cubicTo(14.957, 48.1062, 9.55477, 44.0143, 7, 41.467);
    shapePath.cubicTo(2.6423, 37.1219, 0, 31.1117, 0, 24.4717);
    shapePath.cubicTo(0, 11.2168, 10.7452, 0.47168, 24, 0.47168);
    shapePath.cubicTo(37.2548, 0.47168, 48, 11.2168, 48, 24.4717);
    shapePath.close();

    final innerPaint = Paint()..style = PaintingStyle.fill;
    innerPaint.color = contentColor;
    canvas.drawPath(shapePath, innerPaint);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.19;

    borderPaint.color = _blendColors(contentColor, borderColor);

    canvas.drawPath(shapePath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Color _blendColors(Color backgroundColor, Color foregroundColor) {
    final bgR = backgroundColor.r;
    final bgG = backgroundColor.g;
    final bgB = backgroundColor.b;

    final fgR = foregroundColor.r;
    final fgG = foregroundColor.g;
    final fgB = foregroundColor.b;
    final fgA = foregroundColor.a;

    final resultR = (fgR * fgA) + (bgR * (1 - fgA));
    final resultG = (fgG * fgA) + (bgG * (1 - fgA));
    final resultB = (fgB * fgA) + (bgB * (1 - fgA));

    return Color.fromRGBO(resultR.round(), resultG.round(), resultB.round(), 1.0);
  }
}
