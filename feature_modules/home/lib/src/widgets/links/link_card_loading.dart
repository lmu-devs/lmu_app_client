import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LinkCardLoading extends StatelessWidget {
  const LinkCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuListItem.base(
      mainContentAlignment: MainContentAlignment.top,
      title: BoneMock.words(2),
      subtitle: BoneMock.words(4),
      leadingArea: Container(
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.mediumColors.pressed,
          borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
        ),
        height: LmuIconSizes.mediumSmall,
        width: LmuIconSizes.mediumSmall,
      ),
      trailingArea: const StarIcon(),
    );
  }
}
