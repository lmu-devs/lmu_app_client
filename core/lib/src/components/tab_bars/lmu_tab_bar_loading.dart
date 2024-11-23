import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LmuTabBarLoading extends StatelessWidget {
  const LmuTabBarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      context: context,
      child: LmuTabBar(
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