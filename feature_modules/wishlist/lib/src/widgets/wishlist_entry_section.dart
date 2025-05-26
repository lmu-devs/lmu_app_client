import 'package:core/components.dart';
import 'package:core/constants.dart';
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
      .toList();

  @override
  Widget build(BuildContext context) {
    if (_publicWishlistModels.isEmpty) return const SizedBox.shrink();

    final Map<WishlistStatus, List<WishlistModel>> groupedByStatus = {};
    for (final model in _publicWishlistModels) {
      groupedByStatus.putIfAbsent(model.status, () => []).add(model);
    }

    const statusOrder = [
      WishlistStatus.beta,
      WishlistStatus.development,
      WishlistStatus.none,
    ];

    return ValueListenableBuilder<List<String>>(
      valueListenable: GetIt.I<WishlistUserPreferenceService>().likedWishlistIdsNotifier,
      builder: (context, likedWishlistIds, _) {
        final List<Widget> tiles = [];

        for (final status in statusOrder) {
          final wishlistEntries = groupedByStatus[status];
          if (wishlistEntries == null || wishlistEntries.isEmpty) continue;

          wishlistEntries.sort(
            (a, b) => b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount),
          );

          tiles.add(
            LmuContentTile(
              contentList: wishlistEntries
                  .map(
                    (wishlistModel) => LmuListItem.action(
                      title: wishlistModel.title,
                      titleInTextVisuals: wishlistModel.status.getValue(context).isNotEmpty
                          ? [LmuInTextVisual.text(title: wishlistModel.status.getValue(context))]
                          : [],
                      subtitle: wishlistModel.description,
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
          );

          if (status != statusOrder.last) {
            tiles.add(const SizedBox(height: LmuSizes.size_8));
          }
        }

        return Column(children: tiles);
      },
    );
  }
}
