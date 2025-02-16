import 'package:shared_preferences/shared_preferences.dart';

import 'api/models/wishlist_model.dart';
import 'api/wishlist_api_client.dart';

abstract class WishlistRepository {
  Future<List<WishlistModel>> getWishlistEntries({int? id});

  Future<List<String>?> getLikedWishlistIds();

  Future<bool> toggleWishlistLike(int id);

  Future<void> saveLikedWishlistIds(List<String> ids);

  Future<void> deleteAllLocalData();
}

class ConnectedWishlistRepository implements WishlistRepository {
  ConnectedWishlistRepository({
    required this.wishlistApiClient,
  });

  final WishlistApiClient wishlistApiClient;

  static const String _likedWishlistIdsKey = 'liked_wishlist_ids_key';

  @override
  Future<List<WishlistModel>> getWishlistEntries({int? id}) async {
    try {
      final wishlistEntries = await wishlistApiClient.getWishlistModels(id: id);
      return wishlistEntries;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> getLikedWishlistIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteWishlistIds = prefs.getStringList(_likedWishlistIdsKey);
    return favoriteWishlistIds;
  }

  @override
  Future<bool> toggleWishlistLike(int id) async {
    return await wishlistApiClient.toggleWishlistLike(id: id);
  }

  @override
  Future<void> saveLikedWishlistIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_likedWishlistIdsKey, ids);
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedWishlistIdsKey);
  }
}
