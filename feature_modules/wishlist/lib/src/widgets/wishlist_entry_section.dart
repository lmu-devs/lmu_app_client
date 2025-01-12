import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../../wishlist.dart';
import '../repository/api/api.dart';
import '../util/util.dart';

class WishlistEntrySection extends StatelessWidget {
  const WishlistEntrySection({
    super.key,
    required this.wishlistModels,
    required this.likedWishlistIds,
  });

  final List<WishlistModel> wishlistModels;
  final List<String> likedWishlistIds;

  @override
  Widget build(BuildContext context) {
    return wishlistModels.isNotEmpty
        ? Column(
            children: [
              LmuTileHeadline.base(title: context.locals.wishlist.wishlistEntriesTitle),
              LmuContentTile(
                content: wishlistModels
                    .map(
                      (wishlistModel) => LmuListItem.action(
                        title: wishlistModel.title,
                        titleInTextVisuals: wishlistModel.status.getValue(context).isNotEmpty
                            ? [LmuInTextVisual.text(title: wishlistModel.status.getValue(context))]
                            : [],
                        subtitle: wishlistModel.descriptionShort,
                        trailingTitle: wishlistModel.ratingModel.calculateLikeCount(
                          likedWishlistIds.contains(wishlistModel.id.toString()),
                        ),
                        maximizeLeadingTitleArea: true,
                        actionType: LmuListItemAction.chevron,
                        onTap: () => WishlistDetailsRoute(wishlistModel).go(context),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: LmuSizes.size_24),
            ],
          )
        : const SizedBox.shrink();
  }
}
