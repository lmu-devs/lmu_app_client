import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'dart:math' as math;

import '../services/explore_map_service.dart';

class ExploreCompass extends StatefulWidget {
  const ExploreCompass({
    super.key,
    this.size = 44.0,
    this.onPressed,
  });

  final double size;
  final VoidCallback? onPressed;

  @override
  ExploreCompassState createState() => ExploreCompassState();
}

class ExploreCompassState extends State<ExploreCompass> with TickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double> _rotateAnimation;
  late Tween<double> _rotationTween;

  void _resetRotation(BuildContext context, MapCamera camera) {
    final rotation = camera.rotation;
    final endRotation = (rotation / 360).round() * 360.0;
    if (rotation == endRotation) return;

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(_handleAnimation);
    _rotateAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    );

    _rotationTween = Tween<double>(begin: rotation, end: endRotation);
    _animationController!.forward(from: 0);
  }

  void _handleAnimation() {
    final controller = MapController.of(context);
    controller.rotate(_rotationTween.evaluate(_rotateAnimation));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);

    if (camera.rotation == 0) {
      return const SizedBox.shrink();
    }

    return Transform.rotate(
      angle: camera.rotation * math.pi / 180.0,
      child: GestureDetector(
        onTap: () => {
          _resetRotation(context, camera),
          widget.onPressed,
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.tile,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.colors.neutralColors.borderColors.seperatorLight,
                offset: const Offset(0, 1),
                blurRadius: 1,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ValueListenableBuilder<String>(
                valueListenable: GetIt.I<ExploreMapService>().compassDirectionNotifier,
                builder: (context, direction, _) {
                  return LmuText.bodySmall(direction);
                },
              ),
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: CompassMarkerPainter(context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompassMarkerPainter extends CustomPainter {
  CompassMarkerPainter({required this.context});

  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    final weakTickPaint = Paint()
      ..color = context.colors.neutralColors.textColors.strongColors.disabled ??
          context.colors.neutralColors.textColors.weakColors.base
      ..style = PaintingStyle.fill;

    final mediumTickPaint = Paint()
      ..color = context.colors.neutralColors.textColors.mediumColors.base
      ..style = PaintingStyle.fill;

    final redTickPaint = Paint()
      ..color = context.colors.dangerColors.textColors.strongColors.pressed ??
          context.colors.dangerColors.textColors.strongColors.base
      ..style = PaintingStyle.fill;

    const triangleHeight = 6.5;
    const triangleBaseWidth = 1.25;

    final northPath = Path();
    northPath.moveTo(center.dx, center.dy - radius + 0.5);
    northPath.lineTo(center.dx - triangleBaseWidth * 2.5, center.dy - radius + triangleHeight + 1);
    northPath.lineTo(center.dx + triangleBaseWidth * 2.5, center.dy - radius + triangleHeight + 1);
    northPath.close();
    canvas.drawPath(northPath, redTickPaint);

    final eastPath = Path();
    eastPath.moveTo(center.dx + radius - 0.5, center.dy);
    eastPath.lineTo(center.dx + radius - triangleHeight - 1, center.dy - triangleBaseWidth);
    eastPath.lineTo(center.dx + radius - triangleHeight - 1, center.dy + triangleBaseWidth);
    eastPath.close();
    canvas.drawPath(eastPath, mediumTickPaint);

    final southPath = Path();
    southPath.moveTo(center.dx, center.dy + radius - 0.5);
    southPath.lineTo(center.dx - triangleBaseWidth, center.dy + radius - triangleHeight - 1);
    southPath.lineTo(center.dx + triangleBaseWidth, center.dy + radius - triangleHeight - 1);
    southPath.close();
    canvas.drawPath(southPath, mediumTickPaint);

    final westPath = Path();
    westPath.moveTo(center.dx - radius + 0.5, center.dy);
    westPath.lineTo(center.dx - radius + triangleHeight + 1, center.dy - triangleBaseWidth);
    westPath.lineTo(center.dx - radius + triangleHeight + 1, center.dy + triangleBaseWidth);
    westPath.close();
    canvas.drawPath(westPath, mediumTickPaint);

    final intermediateAngles = [30, 60, 120, 150, 210, 240, 300, 330];

    for (final angleDegrees in intermediateAngles) {
      final angleRadians = angleDegrees * (math.pi / 180);
      _drawIntermediateTick(canvas, center, radius, angleRadians, triangleHeight, triangleBaseWidth, weakTickPaint);
    }
  }

  void _drawIntermediateTick(Canvas canvas, Offset center, double radius, double angle, double triangleHeight,
      double triangleBaseWidth, Paint paint) {
    final tipX = center.dx + radius * math.cos(angle);
    final tipY = center.dy + radius * math.sin(angle);

    final dirX = math.cos(angle);
    final dirY = math.sin(angle);

    final perpX = -dirY;
    final perpY = dirX;

    final path = Path();
    path.moveTo(tipX - dirX * 0.5, tipY - dirY * 0.5);

    final baseX = tipX - dirX * (triangleHeight + 1);
    final baseY = tipY - dirY * (triangleHeight + 1);

    path.lineTo(baseX + perpX * triangleBaseWidth, baseY + perpY * triangleBaseWidth);
    path.lineTo(baseX - perpX * triangleBaseWidth, baseY - perpY * triangleBaseWidth);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
