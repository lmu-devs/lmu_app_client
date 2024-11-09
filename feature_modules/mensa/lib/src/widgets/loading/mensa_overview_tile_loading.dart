import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets.dart';

class MensaOverviewTileLoading extends StatelessWidget {
  const MensaOverviewTileLoading({
    super.key,
    this.hasLargeImage = false
  });

  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: context.colors.gradientColors.gradientLoadingColors.base,
        highlightColor:
            context.colors.gradientColors.gradientLoadingColors.highlight,
      ),
      child: MensaOverviewTile.loading(name: BoneMock.fullName, hasLargeImage: hasLargeImage),
    );
  }
}
