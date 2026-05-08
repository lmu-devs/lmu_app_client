import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../components.dart';

class LmuTabBarLoading extends StatelessWidget {
  const LmuTabBarLoading({super.key, this.hasDivider = false});

  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuTabBar(
        hasDivider: hasDivider,
        onTabChanged: (index, _) {},
        items: List.generate(
          7,
          (index) => LmuTabBarItemData(
            title: BoneMock.words(1),
          ),
        ),
      ),
    );
  }
}
