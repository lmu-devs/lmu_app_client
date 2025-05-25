import 'dart:math' as math;
import 'dart:async'; // For StreamSubscription
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart'; // For device motion
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'card_components/holographic_watermarks.dart';
import 'card_components/holographic_assets.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'dart:developer' as developer;

class HolographicCard extends StatefulWidget {
  // User data
  final String name;
  final String email;
  final String validUntil;
  final String matrikelnr;
  final String lrzKennung;
  final String braille;

  // Card dimensions
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  // Card colors
  final Color cardColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color logoColor;
  final Color hologramColor;
  final Color borderCardColor;
  // Shadow properties
  final double ambientShadowOpacity;
  final double ambientShadowBlur;
  final double ambientShadowYOffset;
  final double primaryShadowOpacity;
  final double midShadowOpacity;
  final double distantShadowOpacity;
  // Movement sensitivity
  final double gestureSensitivity;
  final double gyroSensitivity;
  final double gyroSmoothing;
  final double hologramCenterMovement;
  final double shadowOffsetMultiplier;
  final double shadowIntensityMultiplier;

  // Assets
  final String? logoAsset;
  final String? hologramAsset;
  final String? hologramAsset2;
  final String? shaderpath;
  // Feature toggles
  final bool enableFlip;
  final bool enableGyro;
  final bool enableGestures;
  final bool enableShader;
  final bool enableHolographicEffects;
  final bool enableShadows;

  // Logo properties
  final double logoWidth;
  final double logoHeight;
  final Offset logoPosition;

  // Hologram properties
  final double hologram1Width;
  final double hologram1Height;
  final Offset hologram1Position;
  final double hologram2Width;
  final double hologram2Height;
  final Offset hologram2Position;

  // Shader parameters
  final double shaderWaveFrequency;
  final double shaderPointerInfluence;
  final double shaderColorAmplitude;
  final double shaderBaseAlpha;

  // Axis inversion
  final bool invertGyroX;
  final bool invertGyroY;
  final bool invertGestureX;
  final bool invertGestureY;

  // Callback functions
  final VoidCallback? onCardTap;
  final VoidCallback? onCardDoubleTap;
  final Function(String)? onMatrikelnrCopy;
  final Function(String)? onLrzKennungCopy;

  const HolographicCard({
    super.key,
    // User data
    this.name = 'Anton Rockenstein',
    this.email = 'Anton.Rockenstein@campus.lmu.de',
    this.validUntil = 'Gültig bis 30.09.2025',
    this.matrikelnr = '12842818',
    this.lrzKennung = 'roa1284',
    this.braille = '⠇⠍⠥',

    // Card dimensions
    this.width = 350,
    this.height = 220,
    this.borderRadius = 15,
    this.borderWidth = 2.0,

    // Card colors
    this.cardColor = const Color(0xFFBEBEBE), // Light gray
    this.textColor = Colors.black,
    this.secondaryTextColor = Colors.black54,
    this.logoColor = Colors.black,
    this.hologramColor = Colors.white70,
    this.borderCardColor = Colors.black,

    // Shadow properties
    this.ambientShadowOpacity = 0.2,
    this.ambientShadowBlur = 30,
    this.ambientShadowYOffset = 8,
    this.primaryShadowOpacity = 0.30,
    this.midShadowOpacity = 0.15,
    this.distantShadowOpacity = 0.05,

    // Movement sensitivity
    this.gestureSensitivity = 0.3,
    this.gyroSensitivity = 0.3,
    this.gyroSmoothing = 0.85,
    this.hologramCenterMovement = 0.3,
    this.shadowOffsetMultiplier = 25,
    this.shadowIntensityMultiplier = 2.5,

    // Assets
    this.logoAsset = 'packages/core/assets/holograms/legal_logo.svg',
    this.hologramAsset = 'packages/core/assets/holograms/LMU-Sigel.svg',
    this.hologramAsset2 = 'packages/core/assets/holograms/LMUcard.svg',
    this.shaderpath =
        'packages/core/assets/shader/holographic_shader.frag.glsl',

    // Feature toggles
    this.enableFlip = true,
    this.enableGyro = true,
    this.enableGestures = true,
    this.enableShader = true,
    this.enableHolographicEffects = true,
    this.enableShadows = true,

    // Logo properties
    this.logoWidth = 62,
    this.logoHeight = 32,
    this.logoPosition = const Offset(20, 20),

    // Hologram properties
    this.hologram1Width = 150,
    this.hologram1Height = 150,
    this.hologram1Position = const Offset(-1, -1), // -1 means bottom right
    this.hologram2Width = double.infinity, // Use width of the card
    this.hologram2Height = 40,
    this.hologram2Position = const Offset(0, -1), // -1 for bottom means bottom
    // Shader parameters
    this.shaderWaveFrequency = 5.0,
    this.shaderPointerInfluence = 5.0,
    this.shaderColorAmplitude = 0.03,
    this.shaderBaseAlpha = 0.5,

    // Axis inversion
    this.invertGyroX = false,
    this.invertGyroY = false,
    this.invertGestureX = false,
    this.invertGestureY = false,

    // Callback functions
    this.onCardTap,
    this.onCardDoubleTap,
    this.onMatrikelnrCopy,
    this.onLrzKennungCopy,
  });

  @override
  State<HolographicCard> createState() => _HolographicCardState();
}

class _HolographicCardState extends State<HolographicCard>
    with TickerProviderStateMixin {
  Offset _offset = Offset.zero; // To store the pointer offset
  late AnimationController _returnToCenterController;
  late Animation<Offset> _returnAnimation;

  // For device motion
  Offset _gyroscopeOffset = Offset.zero;
  Offset _targetGyroscopeOffset = Offset.zero;
  StreamSubscription? _gyroscopeSubscription;
  late AnimationController _gyroSmoothingController;
  DateTime _lastGyroUpdate = DateTime.now();
  static const _minUpdateInterval = Duration(milliseconds: 16); // Cap at ~60fps

  // For flip animation
  late AnimationController _flipController;
  bool _isFlipped = false;

  ui.FragmentProgram? _holographicProgram;

  @override
  void initState() {
    super.initState();
    _returnToCenterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _returnToCenterController.addListener(() {
      setState(() {
        _offset = _returnAnimation.value;
      });
    });

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _gyroSmoothingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60fps
    )..addListener(_updateGyroscope);

    // Only subscribe to gyroscope events if enabled
    if (widget.enableGyro) {
      _gyroscopeSubscription = gyroscopeEvents.listen(_handleGyroscopeEvent);
    }
    print(widget.shaderpath);
    _loadHolographicShaderFromPath(widget.shaderpath);
  }

  void _handleGyroscopeEvent(GyroscopeEvent event) {
    final now = DateTime.now();
    if (now.difference(_lastGyroUpdate) < _minUpdateInterval) {
      return; // Skip update if too soon
    }
    _lastGyroUpdate = now;

    // Apply inversion if specified
    final yFactor = widget.invertGyroY ? 1 : -1;
    final xFactor = widget.invertGyroX ? -1 : 1;

    _targetGyroscopeOffset = Offset(
      _targetGyroscopeOffset.dx * widget.gyroSmoothing +
          (yFactor * event.y * widget.gyroSensitivity) *
              (1 - widget.gyroSmoothing),
      _targetGyroscopeOffset.dy * widget.gyroSmoothing +
          (xFactor * event.x * widget.gyroSensitivity) *
              (1 - widget.gyroSmoothing),
    );

    // Ensure animation is running
    if (!_gyroSmoothingController.isAnimating) {
      _gyroSmoothingController.repeat();
    }
  }

  void _updateGyroscope() {
    if (!mounted) return;

    setState(() {
      _gyroscopeOffset = Offset(
        _gyroscopeOffset.dx +
            (_targetGyroscopeOffset.dx - _gyroscopeOffset.dx) * 0.1,
        _gyroscopeOffset.dy +
            (_targetGyroscopeOffset.dy - _gyroscopeOffset.dy) * 0.1,
      );
    });
  }

  Future<void> _loadHolographicShaderFromPath(String? path) async {
    print('Shader loading initiated.');

    if (!widget.enableShader || path == null) {
      print(
          'Shader loading skipped: ${path == null ? 'Path is null' : 'Shader disabled'}');
      setState(() {
        _holographicProgram = null;
      });
      return;
    }

    try {
      final stopwatch = Stopwatch()..start();
      final program = await ui.FragmentProgram.fromAsset(path);
      stopwatch.stop();

      print('Shader loaded in ${stopwatch.elapsedMilliseconds}ms from "$path"');

      if (mounted) {
        setState(() {
          _holographicProgram = program;
        });
      }
    } catch (e) {
      print('Failed to load shader from "$path": $e');

      setState(() {
        _holographicProgram = null;
      });
    }
  }

  @override
  void dispose() {
    _returnToCenterController.dispose();
    _flipController.dispose();
    _gyroSmoothingController.dispose();
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Parallax rotations from gestures (offset is now -0.5 to 0.5)
    final double gestureRotateX =
        widget.enableGestures ? -_offset.dy * widget.gestureSensitivity : 0.0;
    final double gestureRotateY =
        widget.enableGestures ? _offset.dx * widget.gestureSensitivity : 0.0;

    // Parallax rotations from gyroscope
    final double gyroRotateX = widget.enableGyro
        ? -_gyroscopeOffset.dy
        : 0.0; // dy influences X-axis rotation
    final double gyroRotateY = widget.enableGyro
        ? _gyroscopeOffset.dx
        : 0.0; // dx influences Y-axis rotation

    // Combined rotation
    final double finalRotateX = gestureRotateX + gyroRotateX;
    final double finalRotateY = gestureRotateY + gyroRotateY;

    return GestureDetector(
      onTap: widget.onCardTap != null
          ? () {
              developer.log('Card tapped', name: 'HolographicCard');
              widget.onCardTap!();
            }
          : null,
      onPanStart: widget.enableGestures
          ? (details) {
              _returnToCenterController.stop();
            }
          : null,
      onPanUpdate: widget.enableGestures
          ? (details) {
              final RenderBox renderBox =
                  context.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(
                details.globalPosition,
              );
              setState(() {
                _offset = Offset(
                  widget.invertGestureX
                      ? -((localPosition.dx / renderBox.size.width) - 0.5)
                      : ((localPosition.dx / renderBox.size.width) - 0.5),
                  widget.invertGestureY
                      ? -((localPosition.dy / renderBox.size.height) - 0.5)
                      : ((localPosition.dy / renderBox.size.height) - 0.5),
                );
              });
            }
          : null,
      onPanEnd: widget.enableGestures
          ? (details) {
              _returnAnimation = Tween<Offset>(
                begin: _offset,
                end: Offset.zero, // Animate back to center
              ).animate(
                CurvedAnimation(
                  parent: _returnToCenterController,
                  curve: Curves.easeOut,
                ),
              );
              _returnToCenterController.forward(from: 0);
            }
          : null,
      onDoubleTap: widget.enableFlip
          ? () {
              if (_isFlipped) {
                _flipController.reverse();
              } else {
                _flipController.forward();
              }
              _isFlipped = !_isFlipped;

              if (widget.onCardDoubleTap != null) {
                developer.log('Card double tapped', name: 'HolographicCard');
                widget.onCardDoubleTap!();
              }
            }
          : null,
      child: AnimatedBuilder(
        // Use AnimatedBuilder for flip animation
        animation: _flipController,
        builder: (context, child) {
          final double flipValue = _flipController.value;
          final Matrix4 flipTransform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective for flip
            ..rotateY(math.pi * flipValue); // Rotate around Y-axis

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective for parallax
              ..rotateX(finalRotateX)
              ..rotateY(finalRotateY),
            alignment: FractionalOffset.center,
            child: Transform(
              // Apply flip transform
              transform: flipTransform,
              alignment: FractionalOffset.center,
              child: Builder(
                builder: (context) {
                  // Calculate combined movement here so it's available for shadow
                  final combinedX = _offset.dx + _gyroscopeOffset.dx;
                  final combinedY = _offset.dy + _gyroscopeOffset.dy;

                  // Calculate shadow values based on tilt
                  final shadowIntensity =
                      math.sqrt(combinedX * combinedX + combinedY * combinedY) *
                          widget.shadowIntensityMultiplier;
                  final shadowIntensityLimited = shadowIntensity.clamp(
                    0.0,
                    1.0,
                  );

                  // Shadow direction based on tilt
                  final shadowOffsetX =
                      -combinedX * widget.shadowOffsetMultiplier;
                  final shadowOffsetY =
                      -combinedY * widget.shadowOffsetMultiplier;

                  // Shadow size increases with intensity
                  final shadowSpreadBase = 0.1;
                  final shadowSpread =
                      shadowSpreadBase + shadowIntensityLimited * 1.0;

                  // Shadow blur increases with distance from card
                  final shadowBlurBase = 6.0;
                  final shadowBlur =
                      shadowBlurBase + shadowIntensityLimited * 25.0;

                  return Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      boxShadow: widget.enableShadows
                          ? [
                              // Ambient soft shadow that's always visible for resting state
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  widget.ambientShadowOpacity,
                                ),
                                blurRadius: widget.ambientShadowBlur,
                                offset: Offset(
                                  0,
                                  widget.ambientShadowYOffset,
                                ),
                                spreadRadius: 0,
                              ),
                              // Primary shadow - closest to card, follows movement most
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  widget.primaryShadowOpacity *
                                      shadowIntensityLimited,
                                ),
                                blurRadius: shadowBlur * 0.3,
                                offset: Offset(
                                  shadowOffsetX * 0.8,
                                  shadowOffsetY * 0.8 + 2,
                                ),
                                spreadRadius: shadowSpread * 0.3,
                              ),
                              // Mid-level shadow - larger spread, more diffuse
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  widget.midShadowOpacity *
                                      shadowIntensityLimited,
                                ),
                                blurRadius: shadowBlur * 0.8,
                                offset: Offset(
                                  shadowOffsetX * 0.9,
                                  shadowOffsetY * 0.9 + 6,
                                ),
                                spreadRadius: shadowSpread * 0.8,
                              ),
                              // Distant shadow - largest, most diffuse
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  widget.distantShadowOpacity *
                                      shadowIntensityLimited,
                                ),
                                blurRadius: shadowBlur * 1.5,
                                offset: Offset(
                                  shadowOffsetX,
                                  shadowOffsetY + 10,
                                ),
                                spreadRadius: shadowSpread * 1.5,
                              ),
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: Stack(
                        children: [
                          // Base card with holographic effects
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              if (_holographicProgram == null ||
                                  !widget.enableShader) {
                                return ui.Gradient.linear(
                                  Offset.zero,
                                  Offset(bounds.width, bounds.height),
                                  [Colors.transparent, Colors.transparent],
                                );
                              }

                              final shader =
                                  _holographicProgram!.fragmentShader();

                              // Combine touch and gyroscope effects
                              final combinedX =
                                  widget.enableGestures ? _offset.dx : 0.0;
                              final combinedY =
                                  widget.enableGestures ? _offset.dy : 0.0;
                              final gyroX =
                                  widget.enableGyro ? _gyroscopeOffset.dx : 0.0;
                              final gyroY =
                                  widget.enableGyro ? _gyroscopeOffset.dy : 0.0;

                              final totalX = combinedX + gyroX;
                              final totalY = combinedY + gyroY;

                              // Mirror the effect when card is flipped
                              final effectX = _flipController.value >= 0.5
                                  ? -totalX
                                  : totalX;
                              final effectY = totalY;

                              final centerX = 0.5 +
                                  (-effectX * widget.hologramCenterMovement)
                                      .clamp(-0.3, 0.3);
                              final centerY = 0.5 +
                                  (-effectY * widget.hologramCenterMovement)
                                      .clamp(-0.3, 0.3);

                              shader.setFloat(0, bounds.width);
                              shader.setFloat(1, bounds.height);
                              shader.setFloat(
                                2,
                                (effectX + 0.5).clamp(0.0, 1.0),
                              );
                              shader.setFloat(
                                3,
                                (effectY + 0.5).clamp(0.0, 1.0),
                              );
                              shader.setFloat(4, centerX);
                              shader.setFloat(5, centerY);
                              // Pass custom shader parameters
                              shader.setFloat(6, widget.shaderWaveFrequency);
                              shader.setFloat(7, widget.shaderPointerInfluence);
                              shader.setFloat(8, widget.shaderColorAmplitude);
                              shader.setFloat(9, widget.shaderBaseAlpha);
                              return shader;
                            },
                            blendMode: BlendMode.srcOver,
                            child: Container(
                              width: widget.width,
                              height: widget.height,
                              color: widget.cardColor,
                            ),
                          ),

                          // Holographic watermarks layer
                          if (_flipController.value < 0.5) ...[
                            HolographicWatermarks(
                              width: widget.width,
                              height: widget.height,
                              name: widget.name,
                              matrikelnr: widget.matrikelnr,
                              hologramColor: widget.hologramColor,
                              enableHolographicEffects:
                                  widget.enableHolographicEffects,
                              combinedX: combinedX,
                              combinedY: combinedY,
                            ),
                            HolographicAssets(
                              hologramAsset: widget.hologramAsset,
                              hologramAsset2: widget.hologramAsset2,
                              hologramColor: widget.hologramColor,
                              enableHolographicEffects:
                                  widget.enableHolographicEffects,
                              combinedX: combinedX,
                              combinedY: combinedY,
                              hologram1Width: widget.hologram1Width,
                              hologram1Height: widget.hologram1Height,
                              hologram1Position: widget.hologram1Position,
                              hologram2Width: widget.hologram2Width,
                              hologram2Height: widget.hologram2Height,
                              hologram2Position: widget.hologram2Position,
                            ),
                          ],

                          // Content layer (front or back)
                          Container(
                            width: widget.width,
                            height: widget.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              border: Border.all(
                                color: widget.borderCardColor,
                                width: widget.borderWidth,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              child: Stack(
                                children: [
                                  if (_flipController.value < 0.5) ...[
                                    // Front content
                                    // LMU Logo
                                    Positioned(
                                      top: widget.logoPosition.dy,
                                      left: widget.logoPosition.dx,
                                      child: widget.logoAsset != null
                                          ? SvgPicture.asset(
                                              widget.logoAsset!,
                                              width: widget.logoWidth,
                                              height: widget.logoHeight,
                                              colorFilter: ColorFilter.mode(
                                                widget.logoColor,
                                                BlendMode.srcIn,
                                              ),
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  color: Colors.black,
                                                  child: Text(
                                                    'LMU',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'LUDWIG-\nMAXIMILIANS-\nUNIVERSITÄT\nMÜNCHEN',
                                                  style: TextStyle(
                                                    color: widget.textColor,
                                                    fontSize: 5,
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),

                                    // Name
                                    Positioned(
                                      top: 70,
                                      left: 20,
                                      child: Text(
                                        widget.name,
                                        style: TextStyle(
                                          color: widget.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    // Email
                                    Positioned(
                                      top: 95,
                                      left: 20,
                                      child: Text(
                                        widget.email,
                                        style: TextStyle(
                                          color: widget.secondaryTextColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),

                                    // Valid until
                                    Positioned(
                                      top: 115,
                                      left: 20,
                                      child: Text(
                                        widget.validUntil,
                                        style: TextStyle(
                                          color: widget.textColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),

                                    // Matrikelnr
                                    Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Matrikelnr',
                                            style: TextStyle(
                                              color: widget.secondaryTextColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                widget.matrikelnr,
                                                style: TextStyle(
                                                  color: widget.textColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap:
                                                    widget.onMatrikelnrCopy !=
                                                            null
                                                        ? () {
                                                            developer.log(
                                                              'Copying Matrikelnr: ${widget.matrikelnr}',
                                                              name:
                                                                  'HolographicCard',
                                                            );
                                                            Clipboard.setData(
                                                              ClipboardData(
                                                                text: widget
                                                                    .matrikelnr,
                                                              ),
                                                            );
                                                            widget
                                                                .onMatrikelnrCopy!(
                                                              widget.matrikelnr,
                                                            );
                                                          }
                                                        : null,
                                                child: Icon(
                                                  Icons.copy,
                                                  color:
                                                      widget.secondaryTextColor,
                                                  size: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // LRZ Kennung
                                    Positioned(
                                      bottom: 20,
                                      right: 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'LRZ Kennung',
                                            style: TextStyle(
                                              color: widget.secondaryTextColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                widget.lrzKennung,
                                                style: TextStyle(
                                                  color: widget.textColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap:
                                                    widget.onLrzKennungCopy !=
                                                            null
                                                        ? () {
                                                            developer.log(
                                                              'Copying LRZ Kennung: ${widget.lrzKennung}',
                                                              name:
                                                                  'HolographicCard',
                                                            );
                                                            Clipboard.setData(
                                                              ClipboardData(
                                                                text: widget
                                                                    .lrzKennung,
                                                              ),
                                                            );
                                                            widget
                                                                .onLrzKennungCopy!(
                                                              widget.lrzKennung,
                                                            );
                                                          }
                                                        : null,
                                                child: Icon(
                                                  Icons.copy,
                                                  color:
                                                      widget.secondaryTextColor,
                                                  size: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Braille
                                    Positioned(
                                      top: 30,
                                      right: 30,
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..scale(-1.0, 1.0),
                                        child: Text(
                                          widget.braille,
                                          style: TextStyle(
                                            color: widget.textColor.withOpacity(
                                              0.3,
                                            ),
                                            fontSize: 24,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    // Back content
                                    Center(
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..rotateY(math.pi),
                                        child: Text(
                                          'Card Back',
                                          style: TextStyle(
                                            color: widget.textColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
