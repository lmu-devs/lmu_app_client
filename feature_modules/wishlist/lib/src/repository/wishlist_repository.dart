import 'package:shared_api/user.dart';
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
    required this.userService,
  });

  final WishlistApiClient wishlistApiClient;
  final UserService userService;

  static const String _likedWishlistIdsKey = 'liked_wishlist_ids_key';

  @override
  Future<List<WishlistModel>> getWishlistEntries({int? id}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final userApiKey = userService.userApiKey;
      final wishlistEntries = await wishlistApiClient.getWishlistModels(id: id, userApiKey: userApiKey);
      return wishlistEntries;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> getLikedWishlistIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteMensaIds = prefs.getStringList(_likedWishlistIdsKey);
    return favoriteMensaIds;
  }

  @override
  Future<bool> toggleWishlistLike(int id) async {
    final userApiKey = userService.userApiKey;

    if (userApiKey == null) throw Exception('User api key is null');

    return await wishlistApiClient.toggleWishlistLike(
      id: id,
      userApiKey: userApiKey,
    );
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
