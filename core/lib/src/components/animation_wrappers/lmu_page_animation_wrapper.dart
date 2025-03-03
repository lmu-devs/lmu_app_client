import 'package:flutter/material.dart';

class LmuPageAnimationWrapper extends StatelessWidget {
  const LmuPageAnimationWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: child,
    );
  }
}
