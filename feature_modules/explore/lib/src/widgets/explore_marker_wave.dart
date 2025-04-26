import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// A pulsing/searching marker animation that emits bursts of waves.
///
/// * A *burst* = N waves (default 4).
/// * Each wave starts `waveSpacing` after the previous one and expands for
///   `waveDuration` until it reaches its maximum radius while fading out.
/// * After the last wave of a burst has *started*, the widget waits
///   `pauseDuration` before the next burst begins.
///
/// Visually this looks like a search radar ping: *ping‑ping‑ping‑ping — pause —*
/// and then it repeats.
class MarkerWave extends StatefulWidget {
  /// Color of the wave stroke. If null, `Theme.of(context).primaryColor`.
  final Color? color;

  /// Minimum radius of a wave when it is spawned (at z = `maxZoomLevel`).
  final double baseMinRadius;

  /// Maximum radius a wave reaches before it disappears (at z = `maxZoomLevel`).
  final double baseMaxRadius;

  /// How long it takes **one** wave to expand from `baseMinRadius` → `baseMaxRadius`.
  final Duration waveDuration;

  /// Delay between the start of two consecutive waves inside one burst.
  final Duration waveSpacing;

  /// Pause after the **last** wave of a burst has started.
  final Duration pauseDuration;

  /// Global opacity multiplier (0‑1). Each wave additionally fades out itself.
  final double opacity;

  /// Blur applied to the stroke.
  final double blurIntensity;

  final double gradientStartOpacity; // kept for compatibility – no longer used
  final double gradientEndOpacity; // kept for compatibility – no longer used

  /// The highest zoom level in your map (used to calculate zoom scaling).
  final double maxZoomLevel;

  /// Exponential strength of the zoom scaling. `1.0` = halve/double radius per zoom step.
  final double zoomScaleFactor;

  /// Position of the marker the waves originate from.
  final LatLng? selectedMarkerPosition;

  /// How many waves are sent out per burst.
  final int numberOfWaves;

  /// Shift the wave center on the y‑axis (helps to align with a pin icon).
  final double transformY;

  /// Whether the animation repeats automatically.
  final bool repeat;

  /// Delay before the very first burst (useful when mounting the widget).
  final Duration initialDelay;

  /// Stroke width of a wave.
  final double strokeWidth;

  const MarkerWave({
    super.key,
    this.color,
    this.baseMinRadius = 10.0,
    this.baseMaxRadius = 500.0,
    this.waveDuration = const Duration(milliseconds: 800),
    this.waveSpacing = const Duration(milliseconds: 180),
    this.pauseDuration = const Duration(seconds: 2),
    this.opacity = 0.2,
    this.blurIntensity = 2.0,
    this.gradientStartOpacity = 0.8,
    this.gradientEndOpacity = 0.0,
    this.maxZoomLevel = 18.0,
    this.zoomScaleFactor = 1.0,
    required this.selectedMarkerPosition,
    this.numberOfWaves = 5,
    this.transformY = -10.0,
    this.repeat = true,
    this.initialDelay = const Duration(milliseconds: 300),
    this.strokeWidth = 1,
  });

  @override
  State<MarkerWave> createState() => _MarkerWaveState();
}

class _MarkerWaveState extends State<MarkerWave> with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _shouldShow = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    final totalDuration = _calculateTotalDuration();
    _controller = AnimationController(
      duration: totalDuration,
      vsync: this,
    );

    if (widget.selectedMarkerPosition != null) {
      _startAnimation();
    }
  }

  Duration _calculateTotalDuration() {
    final lastWaveStart = widget.waveSpacing * (widget.numberOfWaves - 1);
    return lastWaveStart + widget.waveDuration + widget.pauseDuration;
  }

  void _startAnimation() {
    setState(() => _shouldShow = false);

    Future.delayed(widget.initialDelay, () {
      if (!mounted) return;

      _controller.reset();
      setState(() => _shouldShow = true);

      if (widget.repeat) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  void didUpdateWidget(MarkerWave oldWidget) {
    super.didUpdateWidget(oldWidget);

    final durationChanged = oldWidget.waveDuration != widget.waveDuration ||
        oldWidget.waveSpacing != widget.waveSpacing ||
        oldWidget.pauseDuration != widget.pauseDuration ||
        oldWidget.numberOfWaves != widget.numberOfWaves;

    if (durationChanged) {
      _controller.duration = _calculateTotalDuration();
    }

    if (oldWidget.selectedMarkerPosition != widget.selectedMarkerPosition &&
        widget.selectedMarkerPosition != null) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedMarkerPosition == null || !_shouldShow) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final camera = MapCamera.of(context);
        final point =
            camera.latLngToScreenPoint(widget.selectedMarkerPosition!);

        // Calculate zoom-adjusted radii
        final zoomFactor = math
            .pow(
                2, (widget.maxZoomLevel - camera.zoom) * widget.zoomScaleFactor)
            .toDouble();
        final minRadius = widget.baseMinRadius / zoomFactor;
        final maxRadius = widget.baseMaxRadius / zoomFactor;

        return CustomPaint(
          size: Size.infinite,
          painter: WavePainter(
            center: point,
            progress: _controller.value,
            color: widget.color ?? Theme.of(context).primaryColor,
            minRadius: minRadius,
            maxRadius: maxRadius,
            opacity: widget.opacity,
            numberOfWaves: widget.numberOfWaves,
            waveDuration: widget.waveDuration,
            waveSpacing: widget.waveSpacing,
            blurIntensity: widget.blurIntensity,
            transformY: widget.transformY,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final math.Point<double> center;
  final double progress;
  final Color color;
  final double minRadius;
  final double maxRadius;
  final double opacity;
  final int numberOfWaves;
  final Duration waveDuration;
  final Duration waveSpacing;
  final double blurIntensity;
  final double transformY;
  final double strokeWidth;

  WavePainter({
    required this.center,
    required this.progress,
    required this.color,
    required this.minRadius,
    required this.maxRadius,
    required this.opacity,
    required this.numberOfWaves,
    required this.waveDuration,
    required this.waveSpacing,
    required this.blurIntensity,
    required this.transformY,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final adjustedCenter = Offset(center.x, center.y + transformY);
    final totalDurationMs = waveDuration.inMilliseconds.toDouble();
    final spacingMs = waveSpacing.inMilliseconds.toDouble();
    final currentTimeMs =
        progress * (totalDurationMs + (spacingMs * (numberOfWaves - 1)));

    for (int i = 0; i < numberOfWaves; i++) {
      final waveStartMs = i * spacingMs;
      final waveTimeMs = currentTimeMs - waveStartMs;

      if (waveTimeMs < 0 || waveTimeMs > totalDurationMs) continue;

      final waveProgress = waveTimeMs / totalDurationMs;
      final radius = minRadius + (maxRadius - minRadius) * waveProgress;
      final waveOpacity = (1.0 - waveProgress) * opacity;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = color.withOpacity(waveOpacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurIntensity);

      canvas.drawCircle(adjustedCenter, radius, paint);
    }
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.center != center ||
        oldDelegate.color != color ||
        oldDelegate.minRadius != minRadius ||
        oldDelegate.maxRadius != maxRadius ||
        oldDelegate.opacity != opacity ||
        oldDelegate.numberOfWaves != numberOfWaves ||
        oldDelegate.waveDuration != waveDuration ||
        oldDelegate.waveSpacing != waveSpacing ||
        oldDelegate.blurIntensity != blurIntensity ||
        oldDelegate.transformY != transformY ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
