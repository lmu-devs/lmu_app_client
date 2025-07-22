import 'dart:math';

import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class DeveloperEncounter extends StatefulWidget {
  const DeveloperEncounter({
    super.key,
    required this.assetName,
    this.height,
    this.fit,
    this.package,
    this.onTap,
  });

  final String assetName;
  final double? height;
  final BoxFit? fit;
  final String? package;
  final void Function()? onTap;

  @override
  State<DeveloperEncounter> createState() => _DeveloperEncounterState();
}

class _DeveloperEncounterState extends State<DeveloperEncounter> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  final Random _random = Random();
  double _rotationAngle = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller);
  }

  void _onTap() {
    LmuVibrations.secondary();
    setState(() {
      _rotationAngle = (_random.nextDouble() - 0.5) * 0.2;
      _rotationAnimation = Tween<double>(
        begin: 0.0,
        end: _rotationAngle,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
    });

    widget.onTap?.call();

    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: Image.asset(
          widget.assetName,
          height: widget.height,
          fit: widget.fit,
          package: widget.package,
        ),
      ),
    );
  }
}
