import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:core/themes.dart';

class LmuSkeleton extends StatelessWidget {
  const LmuSkeleton({
    super.key,
    required this.context,
    required this.child,
  });
  final BuildContext context;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gradientLoadingColors = context.colors.gradientColors.gradientLoadingColors;
    return Skeletonizer(
        effect: ShimmerEffect(
          baseColor: gradientLoadingColors.base,
          highlightColor: gradientLoadingColors.highlight,
        ),
        child: child);
  }
}
