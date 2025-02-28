import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CinemaCardLoading extends StatelessWidget {
  const CinemaCardLoading({
    super.key,
    required this.isLastItem,
  });

  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLastItem ? LmuSizes.none : LmuSizes.size_12),
      padding: const EdgeInsets.all(LmuSizes.size_4),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: const BorderRadius.all(
          Radius.circular(LmuRadiusSizes.mediumLarge),
        ),
      ),
      child: LmuSkeleton(
        child: LmuListItem.base(
          title: BoneMock.title,
          titleInTextVisuals: [LmuInTextVisual.text(title: BoneMock.words(1))],
          subtitle: BoneMock.words(5),
          hasHorizontalPadding: true,
          hasVerticalPadding: true,
        ),
      ),
    );
  }
}
