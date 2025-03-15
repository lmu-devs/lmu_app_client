import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../favicon_fallback.dart';

class BenefitsCardLoading extends StatelessWidget {
  const BenefitsCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuContentTile(
        padding: EdgeInsets.zero,
        contentList: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
              topRight: Radius.circular(LmuRadiusSizes.mediumLarge),
            ),
            child: Container(
              color: context.colors.neutralColors.backgroundColors.mediumColors.pressed,
              height: LmuSizes.size_16 * 10,
              width: double.infinity,
            ),
          ),
          LmuListItem.base(
            title: BoneMock.title,
            subtitle: BoneMock.subtitle,
            leadingArea: const FaviconFallback(size: LmuIconSizes.mediumSmall),
          ),
        ],
      ),
    );
  }
}
