import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:core/components.dart';

import '../widgets.dart';

class MensaOverviewTileLoading extends StatelessWidget {
  const MensaOverviewTileLoading({super.key, this.hasLargeImage = false});

  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      context: context,
      child: MensaOverviewTile.loading(
        name: BoneMock.fullName,
        hasLargeImage: hasLargeImage,
      ),
    );
  }
}

