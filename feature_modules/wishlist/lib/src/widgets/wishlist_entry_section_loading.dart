import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../util/util.dart';

class WishlistEntrySectionLoading extends StatelessWidget {
  const WishlistEntrySectionLoading({
    super.key,
    required this.lengths,
  });

  final Map<WishlistStatus, int> lengths;

  @override
  Widget build(BuildContext context) {
    final validEntries = lengths.entries.where((length) => length.value > 0).toList();

    if (validEntries.isEmpty) return const SizedBox.shrink();

    return Column(
      children: List.generate(validEntries.length, (index) {
        final entry = validEntries[index];
        final isLast = index == validEntries.length - 1;

        return Column(
          children: [
            WishlistSectionSkeleton(title: entry.key.getValue(context), itemCount: entry.value),
            if (!isLast) const SizedBox(height: LmuSizes.size_8),
          ],
        );
      }),
    );
  }
}

class WishlistSectionSkeleton extends StatelessWidget {
  const WishlistSectionSkeleton({
    super.key,
    required this.title,
    required this.itemCount,
  });

  final String title;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      crossAxisAlignment: CrossAxisAlignment.start,
      contentList: [
        Padding(
          padding: const EdgeInsets.only(top: LmuSizes.size_8, left: LmuSizes.size_12),
          child: LmuText.bodyXSmall(title),
        ),
        LmuSkeleton(
          child: Column(
            children: List.generate(
              itemCount,
              (index) => LmuListItem.action(
                title: BoneMock.title,
                subtitle: BoneMock.words(index % 2 != 0 ? 3 : 4),
                maximizeLeadingTitleArea: true,
                actionType: LmuListItemAction.chevron,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
