import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistEntrySectionLoading extends StatelessWidget {
  const WishlistEntrySectionLoading({
    super.key,
    required this.lengths,
  });

  final List<int> lengths;

  @override
  Widget build(BuildContext context) {
    if (lengths.isEmpty) return const SizedBox.shrink();

    return Column(
      children: List.generate(lengths.length, (index) {
        if (lengths[index] == 0) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.only(
              bottom: !(lengths.last == lengths[index])
                  ? LmuSizes.size_8
                  : LmuSizes.none,
          ),
          child: WishlistSectionSkeleton(itemCount: lengths[index]),
        );
      }),
    );
  }
}

class WishlistSectionSkeleton extends StatelessWidget {
  const WishlistSectionSkeleton({
    super.key,
    required this.itemCount,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuContentTile(
      crossAxisAlignment: CrossAxisAlignment.start,
      contentList: [
        Padding(
          padding: const EdgeInsets.only(top: LmuSizes.size_8, left: LmuSizes.size_12),
          child: LmuText.bodyXSmall(BoneMock.chars(7)),
        ),
        Column(
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
        ],
      ),
    );
  }
}
