import 'package:flutter/material.dart';

import '../../../themes.dart';

class LmuAnimatedListView extends StatelessWidget {
  const LmuAnimatedListView({
    super.key,
    required this.valueKey,
    required this.itemCount,
    required this.itemBuilder,
  });

  final String valueKey;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: LmuAnimations.fastSmooth,
      switchOutCurve: LmuAnimations.fastSmooth,
      reverseDuration: const Duration(milliseconds: 50),
      transitionBuilder: (child, animation) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, .7), end: Offset.zero).animate(animation),
        child: child,
      ),
      child: ListView.builder(
        key: ValueKey(valueKey),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
