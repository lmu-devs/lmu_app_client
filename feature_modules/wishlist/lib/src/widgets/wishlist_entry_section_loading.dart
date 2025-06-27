import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistEntrySectionLoading extends StatelessWidget {
  const WishlistEntrySectionLoading({super.key, required this.length});

  final int length;

  @override
  Widget build(BuildContext context) {
    if (length == 0) return const SizedBox.shrink();

    return LmuContentTile(
      contentList: List.generate(
        length,
        (index) => LmuSkeleton(
          child: LmuListItem.action(
            title: BoneMock.title,
            titleInTextVisuals: index < (length / 2) ? [LmuTextBadge(title: BoneMock.words(2))] : [],
            subtitle: BoneMock.words(index % 2 != 0 ? 3 : 4),
            maximizeLeadingTitleArea: true,
            actionType: LmuListItemAction.chevron,
          ),
        ),
      ),
    );
  }
}
