import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class PulsatingRadarLayer extends StatefulWidget {
  final Color? color;
  final double baseMinRadius;
  final double baseMaxRadius;
  final Duration duration;
  final double opacity;
  final int numberOfCircles;
  final double blurIntensity;
  final double gradientStartOpacity;
  final double gradientEndOpacity;
  final double maxZoomLevel;
  final double zoomScaleFactor;
  final Stream<LocationMarkerPosition?>? locationStream;

  const PulsatingRadarLayer({
    super.key,
    this.color,
    this.baseMinRadius = 100.0,
    this.baseMaxRadius = 5000.0,
    this.duration = const Duration(seconds: 2),
    this.opacity = 0.4,
    this.numberOfCircles = 3,
    this.blurIntensity = 3.0,
    this.gradientStartOpacity = 1.0,
    this.gradientEndOpacity = 0.0,
    this.maxZoomLevel = 18.0,
    this.zoomScaleFactor = 1.0,
    this.locationStream,
  });

  @override
  State<PulsatingRadarLayer> createState() => _PulsatingRadarLayerState();
}

class _PulsatingRadarLayerState extends State<PulsatingRadarLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Stream<LocationMarkerPosition?> _locationStream;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    // Initialize the location stream
    _locationStream = widget.locationStream ??
        const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream();
  }

  @override
  void didUpdateWidget(PulsatingRadarLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
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
    return StreamBuilder<LocationMarkerPosition?>(
      stream: _locationStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final camera = MapCamera.of(context);
            final position = snapshot.data!;
            final point = camera.latLngToScreenPoint(position.latLng);

            final (minRadius, maxRadius) = _getRadiusForZoom(camera.zoom);

            return CustomPaint(
              size: Size.infinite,
              painter: RadarPainter(
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
              ),
            );
          },
        );
      },
    );
  }
}

class RadarPainter extends CustomPainter {
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

  RadarPainter({
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
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < numberOfCircles; i++) {
      final adjustedProgress = (progress + (i * (1 / numberOfCircles))) % 1.0;

      final gradient = RadialGradient(
        colors: [
          color.withOpacity(
              (1 - adjustedProgress) * opacity * gradientStartOpacity),
          color.withOpacity(
              (1 - adjustedProgress) * opacity * gradientEndOpacity),
        ],
      );

      final paint = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(
            center: Offset(center.x, center.y),
            radius: maxRadius,
          ),
        )
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurIntensity)
        ..style = PaintingStyle.fill;

      final radius = minRadius + ((maxRadius - minRadius) * adjustedProgress);
      canvas.drawCircle(
        Offset(center.x, center.y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(RadarPainter oldDelegate) {
    return oldDelegate.center != center ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.minRadius != minRadius ||
        oldDelegate.maxRadius != maxRadius ||
        oldDelegate.opacity != opacity ||
        oldDelegate.numberOfCircles != numberOfCircles ||
        oldDelegate.blurIntensity != blurIntensity ||
        oldDelegate.gradientStartOpacity != gradientStartOpacity ||
        oldDelegate.gradientEndOpacity != gradientEndOpacity;
  }
}
