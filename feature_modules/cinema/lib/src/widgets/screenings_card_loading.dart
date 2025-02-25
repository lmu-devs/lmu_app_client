import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ScreeningCardLoading extends StatelessWidget {
  const ScreeningCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 165;

    return LmuSkeleton(
      child: Container(
        height: cardHeight,
        margin: const EdgeInsets.only(bottom: LmuSizes.size_12),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: const BorderRadius.all(
            Radius.circular(LmuRadiusSizes.mediumLarge),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                bottomLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
              ),
              child: Container(
                height: cardHeight,
                width: 116,
                color: context.colors.neutralColors.backgroundColors.mediumColors.base,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(LmuSizes.size_16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LmuText.body(BoneMock.words(3)),
                            LmuText.body(BoneMock.chars(2)),
                          ],
                        ),
                        const SizedBox(height: LmuSizes.size_4),
                        LmuText.bodySmall(BoneMock.words(2)),
                        const SizedBox(height: LmuSizes.size_4),
                        LmuText.bodySmall(BoneMock.words(1)),
                      ],
                    ),
                    Wrap(
                      spacing: LmuSizes.size_4,
                      runSpacing: LmuSizes.size_4,
                      children: [
                        LmuInTextVisual.text(title: BoneMock.words(1)),
                        LmuInTextVisual.text(title: BoneMock.words(1)),
                        LmuInTextVisual.text(title: BoneMock.words(1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
