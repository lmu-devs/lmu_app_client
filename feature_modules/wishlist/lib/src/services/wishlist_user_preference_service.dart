import 'package:core/logging.dart';
import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../bloc/wishlist_cubit.dart';
import '../bloc/wishlist_state.dart';
import '../repository/wishlist_repository.dart';

class WishlistUserPreferenceService {
  WishlistUserPreferenceService();

  final _wishlistRepository = GetIt.I.get<WishlistRepository>();
  final _appLogger = AppLogger();

  Future init() {
    return Future.wait([
      initLikedWishlistIds(),
    ]);
  }

  Future reset() {
    return Future.wait([
      _wishlistRepository.deleteAllLocalData(),
      Future.value(_likedWishlistIdsNotifier.value = []),
    ]);
  }

  final _likedWishlistIdsNotifier = ValueNotifier<List<String>>([]);

  ValueNotifier<List<String>> get likedWishlistIdsNotifier => _likedWishlistIdsNotifier;

  Future<void> initLikedWishlistIds() async {
    final likedWishlistIds = await _wishlistRepository.getLikedWishlistIds() ?? [];
    _likedWishlistIdsNotifier.value = likedWishlistIds;

    _appLogger.logMessage('[WishlistUserPreferenceService]: Local liked wishlist ids: $likedWishlistIds');

    final wishlistCubit = GetIt.I<WishlistCubit>();
    final wishlistCubitState = wishlistCubit.state;
    wishlistCubit.stream.withInitialValue(wishlistCubitState).listen((state) async {
      if (state is WishlistLoadSuccess) {
        final retrievedLikedWishlistIds = state.wishlistModels
            .where((wishlistEntry) => wishlistEntry.ratingModel.isLiked)
            .map((wishlistEntry) => wishlistEntry.id.toString())
            .toList();
        _appLogger
            .logMessage('[WishlistUserPreferenceService]: Retrieved liked wishlist ids: $retrievedLikedWishlistIds');

        final unsyncedLikedWishlistIds =
            likedWishlistIds.where((id) => !retrievedLikedWishlistIds.contains(id.toString())).toList();

        final unsyncedUnlikedWishlistIds =
            retrievedLikedWishlistIds.where((id) => !likedWishlistIds.contains(id.toString())).toList();

        final missingSyncWishlistIds = unsyncedLikedWishlistIds + unsyncedUnlikedWishlistIds;
        for (final missingSyncWishlistId in missingSyncWishlistIds) {
          await _wishlistRepository.toggleWishlistLike(int.parse(missingSyncWishlistId));
        }
      }
    });
  }

  Future<void> toggleLikedWishlistId(String id) async {
    final likedWishlistIds = List<String>.from(_likedWishlistIdsNotifier.value);

    if (likedWishlistIds.contains(id)) {
      likedWishlistIds.remove(id);
    } else {
      likedWishlistIds.insert(0, id);
    }

    _likedWishlistIdsNotifier.value = likedWishlistIds;
    await _wishlistRepository.saveLikedWishlistIds(likedWishlistIds);

    await _wishlistRepository.toggleWishlistLike(int.parse(id));
  }
}
