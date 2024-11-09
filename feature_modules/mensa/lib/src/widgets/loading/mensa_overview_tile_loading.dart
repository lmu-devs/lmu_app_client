import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets.dart';

class MensaOverviewTileLoading extends StatelessWidget {
  const MensaOverviewTileLoading({super.key, this.hasLargeImage = false});

  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    final gradientLoadingColors = context.colors.gradientColors.gradientLoadingColors;
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: gradientLoadingColors.base,
        highlightColor: gradientLoadingColors.highlight,
      ),
      child: MensaOverviewTile.loading(
        name: BoneMock.fullName,
        hasLargeImage: hasLargeImage,
      ),
    );
  }
}
