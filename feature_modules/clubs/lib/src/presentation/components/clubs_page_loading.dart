import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import 'clubs_suggestion_tile.dart';

class ClubsPageLoading extends StatelessWidget {
  const ClubsPageLoading({super.key});

  final _categoryLoadingCount = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        const LmuTileHeadlineLoading(titleLength: 3),
        LmuContentTile(
          content: LmuListItemLoading(
            titleLength: 2,
            subtitleLength: 8,
            action: LmuListItemAction.chevron,
            mainContentAlignment: MainContentAlignment.top,
            leadingArea: Container(
              width: LmuSizes.size_48,
              height: LmuSizes.size_48,
              decoration: BoxDecoration(
                color: context.colors.neutralColors.backgroundColors.base,
                borderRadius: const BorderRadius.all(Radius.circular(LmuSizes.size_8)),
              ),
            ),
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
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
              action: LmuListItemAction.chevron,
              hasDivier: index != _categoryLoadingCount - 1,
              leadingArea: Container(
                width: LmuSizes.size_48,
                height: LmuSizes.size_48,
                decoration: BoxDecoration(
                  color: context.colors.neutralColors.backgroundColors.base,
                  borderRadius: const BorderRadius.all(Radius.circular(LmuSizes.size_8)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
        const LmuSkeleton(child: IgnorePointer(child: ClubsSuggestionTile())),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}
