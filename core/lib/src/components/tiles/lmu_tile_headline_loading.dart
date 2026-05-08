import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components.dart';

class LmuTileHeadlineLoading extends StatelessWidget {
  const LmuTileHeadlineLoading({super.key, this.titleLength = 2});

  final int titleLength;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuTileHeadline.base(
        title: BoneMock.words(titleLength),
      ),
    );
  }
}
