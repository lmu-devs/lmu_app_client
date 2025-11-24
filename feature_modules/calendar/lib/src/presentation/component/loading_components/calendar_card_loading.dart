import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CalendarCardLoading extends StatelessWidget {
  const CalendarCardLoading({
    super.key,
    this.hasColorBar = true,
  });

  final bool hasColorBar;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: Container(
        margin: const EdgeInsets.only(bottom: LmuSizes.size_12),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuSizes.size_8),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// VerticalBar
              hasColorBar
                  ? Padding(
                      padding: const EdgeInsets.all(LmuSizes.size_8),
                      child: Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: context.colors.neutralColors.borderColors.seperatorLight,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(LmuRadiusSizes.mediumLarge),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),

              /// Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, LmuSizes.size_8, LmuSizes.size_8, LmuSizes.size_8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title and Tag
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: LmuText.body(
                              BoneMock.title,
                            ),
                          ),
                          const SizedBox(width: LmuSizes.size_8),
                          LmuInTextVisual.text(
                            title: BoneMock.words(1),
                          ),
                        ],
                      ),

                      const SizedBox(height: LmuSizes.size_2),

                      /// Time
                      LmuText.bodySmall(
                        BoneMock.words(6),
                        maxLines: 1,
                      ),

                      const SizedBox(height: LmuSizes.size_2),

                      /// Location
                      LmuText.bodySmall(
                        BoneMock.words(4),
                        maxLines: 1,
                      ),

                      const SizedBox(height: LmuSizes.size_2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
