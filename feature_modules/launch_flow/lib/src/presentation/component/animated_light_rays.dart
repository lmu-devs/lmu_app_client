import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class AnimatedLightRays extends StatefulWidget {
  const AnimatedLightRays({super.key});

  @override
  State<AnimatedLightRays> createState() => _AnimatedLightRaysState();
}

class _AnimatedLightRaysState extends State<AnimatedLightRays> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0;
      });
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ShaderBuilder(
      (context, shader, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: _RaysPainter(shader, _time, isDarkMode),
        );
      },
      assetKey: 'assets/shader/light_rays.frag',
    );
  }
}

class _RaysPainter extends CustomPainter {
  const _RaysPainter(this.shader, this.time, this.isDarkMode);

  final FragmentShader shader;
  final double time;
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloatUniforms((uniforms) {
      uniforms
        ..setFloat(time) // iTime
        ..setSize(size) // iResolution

        // Light ray 1
        ..setFloat(size.width * 0.45) // uRayPos1.x
        ..setFloat(size.height * -0.4) // uRayPos1.y
        ..setFloat(1.0) // uRayRefDir1.x
        ..setFloat(-0.116) // uRayRefDir1.y
        ..setFloat(36.2214) // uRaySeedA1
        ..setFloat(21.11349) // uRaySeedB1
        ..setFloat(1.0) // uRaySpeed1

        // Light ray 2
        ..setFloat(size.width * 0.55) // uRayPos2.x
        ..setFloat(size.height * -0.6) // uRayPos2.y
        ..setFloat(1.0) // uRayRefDir2.x
        ..setFloat(0.241) // uRayRefDir2.y
        ..setFloat(22.39910) // uRaySeedA2
        ..setFloat(18.0234) // uRaySeedB2
        ..setFloat(1.1) // uRaySpeed2

        // Set ray color (vec3)
        ..setFloat(isDarkMode ? 0.5 : 0.1) // uRayColor.r
        ..setFloat(isDarkMode ? 0.5 : 0.1) // uRayColor.g
        ..setFloat(isDarkMode ? 0.5 : 0.1); // uRayColor.b

      // Rays color
      // ..setColor(isDarkMode ? Colors.white : Colors.black);
    });

    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant _RaysPainter oldDelegate) => oldDelegate.time != time;
}
