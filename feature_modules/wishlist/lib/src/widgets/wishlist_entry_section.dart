import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:core_routes/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../services/wishlist_user_preference_service.dart';
import '../util/util.dart';

class WishlistEntrySection extends StatelessWidget {
  const WishlistEntrySection({super.key, required this.wishlistModels});

  final List<WishlistModel> wishlistModels;

  List<WishlistModel> get _publicWishlistModels => wishlistModels
      .where((model) => model.status != WishlistStatus.hidden && model.status != WishlistStatus.done)
      .toList()
    ..sort(
      (a, b) {
        const statusOrder = {
          WishlistStatus.beta: 0,
          WishlistStatus.development: 1,
          WishlistStatus.none: 2,
        };
        final statusComparison = statusOrder[a.status]!.compareTo(statusOrder[b.status]!);
        if (statusComparison != 0) return statusComparison;
        return b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount);
      },
    );

  @override
  Widget build(BuildContext context) {
    if (_publicWishlistModels.isEmpty) return const SizedBox.shrink();

    return ValueListenableBuilder<List<String>>(
      valueListenable: GetIt.I<WishlistUserPreferenceService>().likedWishlistIdsNotifier,
      builder: (context, likedWishlistIds, _) {
        return LmuContentTile(
          contentList: _publicWishlistModels
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
        );
      },
    );
  }
}
