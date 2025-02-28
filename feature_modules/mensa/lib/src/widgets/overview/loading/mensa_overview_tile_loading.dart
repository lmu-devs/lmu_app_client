import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets.dart';

class MensaOverviewTileLoading extends StatelessWidget {
  const MensaOverviewTileLoading({
    super.key,
    this.hasLargeImage = false,
    this.hasDivider = true,
  });

  final bool hasLargeImage;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: MensaOverviewTile.loading(
        name: BoneMock.fullName,
        hasLargeImage: hasLargeImage,
        hasDivider: hasDivider,
      ),
    );
  }
}
