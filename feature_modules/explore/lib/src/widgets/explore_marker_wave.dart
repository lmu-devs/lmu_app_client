import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MarkerWave extends StatefulWidget {
  final Color? color;
  final double baseMinRadius;
  final double baseMaxRadius;
  final Duration duration;
  final double opacity;
  final double blurIntensity;
  final double gradientStartOpacity;
  final double gradientEndOpacity;
  final double maxZoomLevel;
  final double zoomScaleFactor;
  final LatLng? selectedMarkerPosition;
  final int numberOfCircles;
  final double transformY;
  final bool repeat;
  final Duration delay;
  const MarkerWave({
    super.key,
    this.color,
    this.baseMinRadius = 20.0,
    this.baseMaxRadius = 200.0,
    this.duration = const Duration(milliseconds: 2500),
    this.opacity = 0.6,
    this.blurIntensity = 4.0,
    this.gradientStartOpacity = 1.0,
    this.gradientEndOpacity = 0.0,
    this.maxZoomLevel = 18.0,
    this.zoomScaleFactor = 1.0,
    required this.selectedMarkerPosition,
    this.numberOfCircles = 1,
    this.transformY = 0.0,
    this.repeat = false,
    this.delay = const Duration(milliseconds: 200),
  });

  @override
  State<MarkerWave> createState() => _MarkerWaveState();
}

class _MarkerWaveState extends State<MarkerWave> with TickerProviderStateMixin {
  late AnimationController _controller;
  LatLng? _previousPosition;
  bool _shouldShow = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
      value: 0,
    );

    if (widget.selectedMarkerPosition != null) {
      _triggerAnimation();
    }
  }

  @override
  void didUpdateWidget(MarkerWave oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedMarkerPosition != _previousPosition &&
        widget.selectedMarkerPosition != null) {
      _triggerAnimation();
    }

    _previousPosition = widget.selectedMarkerPosition;

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
  }

  void _triggerAnimation() {
    setState(() {
      _shouldShow = false;
    });

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.reset();
        setState(() {
          _shouldShow = true;
        });
        if (widget.repeat) {
          _controller.repeat();
        } else {
          _controller.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  (double, double) _getRadiusForZoom(double zoom) {
    final zoomFactor = math
        .pow(
          2,
          (widget.maxZoomLevel - zoom) * widget.zoomScaleFactor,
        )
        .toDouble();

    final minRadius = widget.baseMinRadius / zoomFactor;
    final maxRadius = widget.baseMaxRadius / zoomFactor;

    return (minRadius, maxRadius);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedMarkerPosition == null || !_shouldShow) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final camera = MapCamera.of(context);
        final point =
            camera.latLngToScreenPoint(widget.selectedMarkerPosition!);

        final (minRadius, maxRadius) = _getRadiusForZoom(camera.zoom);

        return CustomPaint(
          size: Size.infinite,
          painter: MarkerWavePainter(
            center: point,
            progress: _controller.value,
            color: widget.color ?? Theme.of(context).primaryColor,
            minRadius: minRadius,
            maxRadius: maxRadius,
            opacity: widget.opacity,
            numberOfCircles: widget.numberOfCircles,
            blurIntensity: widget.blurIntensity,
            gradientStartOpacity: widget.gradientStartOpacity,
            gradientEndOpacity: widget.gradientEndOpacity,
            transformY: widget.transformY,
          ),
        );
      },
    );
  }
}

class MarkerWavePainter extends CustomPainter {
  final math.Point<double> center;
  final double progress;
  final Color color;
  final double minRadius;
  final double maxRadius;
  final double opacity;
  final int numberOfCircles;
  final double blurIntensity;
  final double gradientStartOpacity;
  final double gradientEndOpacity;
  final double transformY;

  MarkerWavePainter({
    required this.center,
    required this.progress,
    required this.color,
    required this.minRadius,
    required this.maxRadius,
    required this.opacity,
    required this.numberOfCircles,
    required this.blurIntensity,
    required this.gradientStartOpacity,
    required this.gradientEndOpacity,
    this.transformY = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Only paint circles if progress is less than 1
    if (progress >= 1) return;

    // We'll show 3 circles with fixed spacing
    for (var i = 0; i < 3; i++) {
      // Adjust the spacing between circles
      final circleProgress = progress + (i * 0.33);

      // Only draw this circle if it should be visible
      if (circleProgress <= 1.0) {
        final adjustedCenter = Offset(center.x, center.y + transformY);

        final circleOpacity =
            (1 - circleProgress) * opacity * gradientStartOpacity;

        final gradient = RadialGradient(
          colors: [
            color.withOpacity(circleOpacity),
            color.withOpacity(circleOpacity * gradientEndOpacity),
          ],
        );

        final paint = Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(
              center: adjustedCenter,
              radius: maxRadius,
            ),
          )
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurIntensity)
          ..style = PaintingStyle.fill;

        final radius = minRadius + ((maxRadius - minRadius) * circleProgress);
        canvas.drawCircle(
          adjustedCenter,
          radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(MarkerWavePainter oldDelegate) {
    return oldDelegate.center != center ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.minRadius != minRadius ||
        oldDelegate.maxRadius != maxRadius ||
        oldDelegate.opacity != opacity ||
        oldDelegate.numberOfCircles != numberOfCircles ||
        oldDelegate.blurIntensity != blurIntensity ||
        oldDelegate.gradientStartOpacity != gradientStartOpacity ||
        oldDelegate.gradientEndOpacity != gradientEndOpacity ||
        oldDelegate.transformY != transformY;
  }
}
