import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieTeaserCardLoading extends StatelessWidget {
  const MovieTeaserCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
            child: LmuSkeleton(
              child: Container(
                width: 115,
                height: 165,
                color: context.colors.neutralColors.backgroundColors.mediumColors.base,
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_8),
          SizedBox(
            width: 115,
            child: Wrap(
              spacing: LmuSizes.size_4,
              runSpacing: LmuSizes.size_2,
              alignment: WrapAlignment.center,
              children: [
                LmuInTextVisual.text(title: BoneMock.words(1)),
                LmuInTextVisual.text(title: BoneMock.words(1)),
              ],
            ),
          ),
          const SizedBox(height: LmuSizes.size_8),
          LmuText.bodySmall(BoneMock.words(2)),
        ],
      ),
    );
  }
}
