import 'dart:math';

import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../application/usecase/get_developerdex_usecase.dart';
import '../../domain/model/animal.dart';
import '../../domain/model/lmu_developer.dart';

class DeveloperEncounter extends StatefulWidget {
  const DeveloperEncounter({
    super.key,
    required this.developer,
  });

  final LmuDeveloper developer;

  @override
  State<DeveloperEncounter> createState() => _DeveloperEncounterState();
}

class _DeveloperEncounterState extends State<DeveloperEncounter> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  late final GetDeveloperdexUsecase _getDeveloperdexUsecase;

  final Random _random = Random();
  double _rotationAngle = 0;

  LmuDeveloper get _developer => widget.developer;

  @override
  void initState() {
    super.initState();
    _getDeveloperdexUsecase = GetIt.I.get<GetDeveloperdexUsecase>();

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

  void _onTap(BuildContext context) {
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

    _registerEncounter(context);

    _controller.forward().then((_) => _controller.reverse());
  }

  void _registerEncounter(BuildContext context) {
    final isNew = _getDeveloperdexUsecase.caughtDeveloper(_developer.id);

    if (isNew) {
      LmuToast.of(context).showToast(
        message: "Caught ${_developer.name}!",
        type: ToastType.success,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
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
          _developer.animal.asset,
          height: 128,
          fit: BoxFit.cover,
          package: "developerdex",
        ),
      ),
    );
  }
}
