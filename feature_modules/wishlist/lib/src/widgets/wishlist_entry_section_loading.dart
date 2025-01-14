import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistEntrySectionLoading extends StatelessWidget {
  const WishlistEntrySectionLoading({super.key, required this.length});

  final int length;

  @override
  Widget build(BuildContext context) {
    return length != 0
        ? Column(
            children: [
              LmuTileHeadline.base(title: context.locals.wishlist.wishlistEntriesTitle),
              LmuContentTile(
                content: [
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: List.generate(
                      length,
                      (index) => LmuSkeleton(
                        child: LmuListItem.action(
                          title: BoneMock.title,
                          titleInTextVisuals:
                              index < (length / 2) ? [LmuInTextVisual.text(title: BoneMock.words(2))] : [],
                          subtitle: BoneMock.words(index % 2 != 0 ? 3 : 4),
                          trailingTitle: BoneMock.chars(2),
                          maximizeLeadingTitleArea: true,
                          actionType: LmuListItemAction.chevron,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_24),
            ],
          )
        : const SizedBox.shrink();
  }
}
