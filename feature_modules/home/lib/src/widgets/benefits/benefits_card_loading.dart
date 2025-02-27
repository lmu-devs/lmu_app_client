import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BenefitsCardLoading extends StatelessWidget {
  const BenefitsCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuContentTile(
        padding: EdgeInsets.zero,
        content: [
          Container(
            height: LmuSizes.size_16 * 10,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.neutralColors.backgroundColors.mediumColors.pressed,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                topRight: Radius.circular(LmuRadiusSizes.mediumLarge),
              ),
            ),
          ),
          LmuListItem.base(
            title: BoneMock.title,
            subtitle: BoneMock.subtitle,
            leadingArea: Container(
              decoration: BoxDecoration(
                color: context.colors.neutralColors.backgroundColors.mediumColors.pressed,
                borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
              ),
              height: LmuIconSizes.medium,
              width: LmuIconSizes.medium,
            ),
          ),
        ],
      ),
    );
  }
}
