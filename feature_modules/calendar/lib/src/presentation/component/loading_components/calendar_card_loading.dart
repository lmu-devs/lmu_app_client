import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CalendarCardLoading extends StatelessWidget {
  const CalendarCardLoading({
    super.key,
    this.isHalfWidth = false,
    this.hasColorBar = true,
  });

  final bool isHalfWidth;
  final bool hasColorBar; // To simulate the color bar's presence

  @override
  Widget build(BuildContext context) {
    final cardWidth = isHalfWidth ? (MediaQuery.of(context).size.width - 40) / 2 : double.infinity;

    return LmuSkeleton(
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(bottom: LmuSizes.size_12),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
          // border: Border.all(
          //   color: context.colors.neutralColors.backgroundColors.tile,
          //   width: 2,
          //   strokeAlign: BorderSide.strokeAlignInside,
          // ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Color bar placeholder
              hasColorBar
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: LmuSizes.size_16, top: LmuSizes.size_16, bottom: LmuSizes.size_16),
                      child: Container(
                        width: 4,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(32, 0, 0, 0), // Placeholder color
                          borderRadius: BorderRadius.all(
                            Radius.circular(LmuRadiusSizes.mediumLarge),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),

              /// Content placeholder
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title and Tag row placeholder
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: LmuText.h3(
                              BoneMock.title, // Placeholder for title
                              maxLines: 1,
                              customOverFlow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: LmuSizes.size_8),
                          LmuInTextVisual.text(
                            title: BoneMock.words(1), // Placeholder for tag
                          ),
                        ],
                      ),
                      const SizedBox(height: LmuSizes.size_4),

                      /// Time placeholder
                      LmuText.bodySmall(
                        BoneMock.words(2), // Placeholder for time range
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                      ),
                      const SizedBox(height: LmuSizes.size_4),

                      /// Date placeholder
                      LmuText.bodySmall(
                        BoneMock.words(3), // Placeholder for short date
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                        maxLines: 2,
                        customOverFlow: TextOverflow.ellipsis,
                      ),

                      /// Location placeholder
                      LmuText.bodySmall(
                        BoneMock.words(4), // Placeholder for address
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                        maxLines: 2,
                        customOverFlow: TextOverflow.ellipsis,
                      ),
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
