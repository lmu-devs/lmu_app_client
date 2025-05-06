import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import 'benefit_suggestion_tile.dart';

class BenefitsPageLoading extends StatelessWidget {
  const BenefitsPageLoading({super.key});

  final _categoryLoadingCount = 4;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        const LmuContentTile(
          content: LmuListItemLoading(
            titleLength: 2,
            action: LmuListItemAction.chevron,
          ),
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuContentTile(
          contentList: List.generate(
            _categoryLoadingCount,
            (index) => LmuListItemLoading(
              titleLength: 3,
              subtitleLength: 4,
              leadingArea: Container(
                width: LmuSizes.size_48,
                height: LmuSizes.size_48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LmuSizes.size_6),
                  color: colors.neutralColors.backgroundColors.mediumColors.pressed,
                ),
              ),
              action: LmuListItemAction.chevron,
              hasDivier: index != _categoryLoadingCount - 1,
            ),
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
        const LmuSkeleton(child: IgnorePointer(child: BenefitSuggestionTile())),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}
