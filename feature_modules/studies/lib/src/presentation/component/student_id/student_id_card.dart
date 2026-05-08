import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../domain/model/student_id_data.dart';
import 'card_components/holographic_assets.dart';
import 'card_components/holographic_watermarks.dart';
import 'card_components/student_id_back_side.dart';
import 'card_components/student_id_front_side.dart';
import 'themes/student_id_theme.dart';

class StudentIdCard extends StatefulWidget {
  const StudentIdCard({
    super.key,
    required this.data,
    required this.theme,
    required this.allThemes,
    required this.onThemeSelected,
    this.onMatrikelnrCopy,
    this.onLrzKennungCopy,
  });

  final StudentIdData data;
  final StudentIdTheme theme;
  final List<StudentIdTheme> allThemes;
  final ValueChanged<StudentIdTheme> onThemeSelected;
  final ValueChanged<String>? onMatrikelnrCopy;
  final ValueChanged<String>? onLrzKennungCopy;

  @override
  State<StudentIdCard> createState() => _StudentIdCardState();
}

class _StudentIdCardState extends State<StudentIdCard> with TickerProviderStateMixin {
  // --- Constants ---
  static const _aspectRatio = 350.0 / 220.0;
  static const _borderRadius = 16.0;

  static const _gestureSensitivity = 0.4;
  static const _gyroSensitivity = 0.7;
  static const _gyroSmoothing = 0.85;
  static const _hologramCenterMovement = 0.2;
  static const _shadowOffsetMultiplier = 10.0;

  static const _shaderPath = 'packages/core/assets/shader/holographic_shader.frag.glsl';

  static const _minUpdateInterval = Duration(milliseconds: 16);

  // --- State ---
  Offset _offset = Offset.zero;
  Offset _gyroscopeOffset = Offset.zero;
  Offset _targetGyroscopeOffset = Offset.zero;
  DateTime _lastGyroUpdate = DateTime.now();
  bool _isFlipped = false;
  ui.FragmentProgram? _holographicProgram;

  late final AnimationController _returnToCenterController;
  late Animation<Offset> _returnAnimation;
  late final AnimationController _flipController;
  late final AnimationController _gyroSmoothingController;
  StreamSubscription? _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();

    _returnToCenterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() => _offset = _returnAnimation.value);
      });

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _gyroSmoothingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateGyroscope);

    _gyroscopeSubscription = gyroscopeEvents.listen(_handleGyroscopeEvent);
    _loadShader();
  }

  @override
  void dispose() {
    _returnToCenterController.dispose();
    _flipController.dispose();
    _gyroSmoothingController.dispose();
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  // --- Gyroscope ---

  void _handleGyroscopeEvent(GyroscopeEvent event) {
    final now = DateTime.now();
    if (now.difference(_lastGyroUpdate) < _minUpdateInterval) return;
    _lastGyroUpdate = now;

    _targetGyroscopeOffset = Offset(
      _targetGyroscopeOffset.dx * _gyroSmoothing + (event.y * _gyroSensitivity) * (1 - _gyroSmoothing),
      _targetGyroscopeOffset.dy * _gyroSmoothing + (-event.x * _gyroSensitivity) * (1 - _gyroSmoothing),
    );

    if (!_gyroSmoothingController.isAnimating) {
      _gyroSmoothingController.repeat();
    }
  }

  void _updateGyroscope() {
    if (!mounted) return;
    setState(() {
      _gyroscopeOffset = Offset(
        _gyroscopeOffset.dx + (_targetGyroscopeOffset.dx - _gyroscopeOffset.dx) * 0.1,
        _gyroscopeOffset.dy + (_targetGyroscopeOffset.dy - _gyroscopeOffset.dy) * 0.1,
      );
    });
  }

  // --- Shader ---

  Future<void> _loadShader() async {
    try {
      final program = await ui.FragmentProgram.fromAsset(_shaderPath);
      if (mounted) {
        setState(() => _holographicProgram = program);
      }
    } catch (_) {
      // Shader unavailable — card works without it
    }
  }

  // --- Build ---

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 32;
    final cardHeight = cardWidth / _aspectRatio;

    final gestureRotateX = -_offset.dy * _gestureSensitivity;
    final gestureRotateY = _offset.dx * _gestureSensitivity;
    final gyroRotateX = -_gyroscopeOffset.dy;
    final gyroRotateY = _gyroscopeOffset.dx;
    final finalRotateX = gestureRotateX + gyroRotateX;
    final finalRotateY = gestureRotateY + gyroRotateY;

    return GestureDetector(
      onPanStart: (_) => _returnToCenterController.stop(),
      onPanUpdate: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final local = renderBox.globalToLocal(details.globalPosition);
        setState(() {
          _offset = Offset(
            (local.dx / renderBox.size.width) - 0.5,
            (local.dy / renderBox.size.height) - 0.5,
          );
        });
      },
      onPanEnd: (_) {
        _returnAnimation = Tween<Offset>(begin: _offset, end: Offset.zero).animate(
          CurvedAnimation(parent: _returnToCenterController, curve: Curves.easeOut),
        );
        _returnToCenterController.forward(from: 0);
      },
      onDoubleTap: () {
        _isFlipped ? _flipController.reverse() : _flipController.forward();
        _isFlipped = !_isFlipped;
      },
      child: AnimatedBuilder(
        animation: _flipController,
        builder: (context, child) {
          final flipValue = _flipController.value;
          final flipTransform = Matrix4.identity()
            ..setEntry(3, 2, 0.0005)
            ..rotateY(math.pi * flipValue);

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateX(finalRotateX)
              ..rotateY(finalRotateY),
            alignment: FractionalOffset.center,
            child: Transform(
              transform: flipTransform,
              alignment: FractionalOffset.center,
              child: _buildCardBody(flipValue, cardWidth, cardHeight),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardBody(double flipValue, double cardWidth, double cardHeight) {
    final combinedX = _offset.dx + _gyroscopeOffset.dx;
    final combinedY = _offset.dy + _gyroscopeOffset.dy;
    final showFront = flipValue < 0.5;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        boxShadow: _buildShadows(combinedX, combinedY),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: ShaderMask(
          shaderCallback: (bounds) => _buildShaderCallback(bounds, combinedX, combinedY),
          blendMode: BlendMode.srcOver,
          child: Stack(
            children: [
              // Background
              Container(
                width: cardWidth,
                height: cardHeight,
                color: widget.theme.cardColor,
              ),

              // Holographic layers (front only)
              if (showFront) ...[
                HolographicWatermarks(
                  width: cardWidth,
                  height: cardHeight,
                  name: widget.data.name,
                  matrikelnr: widget.data.matrikelnr,
                  hologramColor: widget.theme.hologramColor,
                  combinedX: combinedX,
                  combinedY: combinedY,
                ),
                HolographicAssets(
                  hologramColor: widget.theme.hologramColor,
                  combinedX: combinedX,
                  combinedY: combinedY,
                ),
              ],

              // Content with border
              Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  border: Border.all(
                    color: widget.theme.borderColor,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  child: showFront
                      ? StudentIdFrontSide(
                          data: widget.data,
                          theme: widget.theme,
                          onMatrikelnrCopy: widget.onMatrikelnrCopy,
                          onLrzKennungCopy: widget.onLrzKennungCopy,
                        )
                      : StudentIdBackSide(
                          allThemes: widget.allThemes,
                          currentTheme: widget.theme,
                          onThemeSelected: widget.onThemeSelected,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Shadows ---

  List<BoxShadow> _buildShadows(double combinedX, double combinedY) {
    final intensity = math.sqrt(combinedX * combinedX + combinedY * combinedY).clamp(0.0, 1.0);
    final offsetX = -combinedX * _shadowOffsetMultiplier;
    final offsetY = -combinedY * _shadowOffsetMultiplier;
    final spread = 0.2 + intensity * 2.0;
    final blur = 6.0 + intensity * 25.0;

    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 20,
        offset: const Offset(0, 3),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.1 * intensity),
        blurRadius: blur * 0.3,
        offset: Offset(offsetX * 0.8, offsetY * 0.8 + 2),
        spreadRadius: spread * 0.3,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.05 * intensity),
        blurRadius: blur * 0.8,
        offset: Offset(offsetX * 0.9, offsetY * 0.9 + 6),
        spreadRadius: spread * 0.8,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.02 * intensity),
        blurRadius: blur * 1.5,
        offset: Offset(offsetX, offsetY + 10),
        spreadRadius: spread * 1.5,
      ),
    ];
  }

  // --- Shader ---

  Shader _buildShaderCallback(Rect bounds, double combinedX, double combinedY) {
    if (_holographicProgram == null) {
      return ui.Gradient.linear(
        Offset.zero,
        Offset(bounds.width, bounds.height),
        [Colors.transparent, Colors.transparent],
      );
    }

    final shader = _holographicProgram!.fragmentShader();

    final totalX = _offset.dx + _gyroscopeOffset.dx;
    final totalY = _offset.dy + _gyroscopeOffset.dy;
    final effectX = _flipController.value >= 0.5 ? -totalX : totalX;
    final effectY = totalY;

    final centerX = 0.5 + (-effectX * _hologramCenterMovement).clamp(-0.3, 0.3);
    final centerY = 0.5 + (-effectY * _hologramCenterMovement).clamp(-0.3, 0.3);

    shader.setFloat(0, bounds.width);
    shader.setFloat(1, bounds.height);
    shader.setFloat(2, (effectX + 0.5).clamp(0.0, 1.0));
    shader.setFloat(3, (effectY + 0.5).clamp(0.0, 1.0));
    shader.setFloat(4, centerX);
    shader.setFloat(5, centerY);
    shader.setFloat(6, widget.theme.shaderWaveFrequency);
    shader.setFloat(7, widget.theme.shaderPointerInfluence);
    shader.setFloat(8, widget.theme.shaderColorAmplitude);
    shader.setFloat(9, widget.theme.shaderBaseAlpha);

    return shader;
  }
}
