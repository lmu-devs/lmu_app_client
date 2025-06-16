import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../themes.dart';

class LmuSkeleton extends StatelessWidget {
  const LmuSkeleton({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gradientLoadingColors = context.colors.gradientColors.gradientLoadingColors;
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: gradientLoadingColors.base,
        highlightColor: gradientLoadingColors.highlight,
      ),
      child: child,
    );
  }
}
