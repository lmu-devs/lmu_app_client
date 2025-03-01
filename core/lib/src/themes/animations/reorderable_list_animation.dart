import 'package:flutter/cupertino.dart';

import '../../../themes.dart';

AnimatedBuilder reorderableListAnimation(Animation<double> animation, Widget child, {bool isReverse = false}) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: LmuAnimations.gentle,
          reverseCurve: isReverse ? LmuAnimations.gentle.flipped : Curves.easeInCubic,
        ),
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: animation,
            curve: LmuAnimations.gentle,
            reverseCurve: isReverse ? LmuAnimations.gentle.flipped : Curves.easeInCubic,
          ),
          child: child,
        ),
      );
    },
    child: child,
  );
}
