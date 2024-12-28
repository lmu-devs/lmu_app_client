import 'package:shared_api/user.dart';

import 'api/models/wishlist_model.dart';
import 'api/wishlist_api_client.dart';

abstract class WishlistRepository {
  Future<List<WishlistModel>> getWishlistEntries({int? id});

  Future<bool> toggleWishlistLike(int id);
}

/// WishlistRepository implementation for fetching wishlist data from the API
class ConnectedWishlistRepository implements WishlistRepository {
  ConnectedWishlistRepository({
    required this.wishlistApiClient,
    required this.userService,
  });

  final WishlistApiClient wishlistApiClient;
  final UserService userService;

  /// Function to fetch mensa models from the API
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
  Future<bool> toggleWishlistLike(int id) async {
    final userApiKey = userService.userApiKey;

    if (userApiKey == null) throw Exception('User api key is null');

    return await wishlistApiClient.toggleWishlistLike(
      id: id,
      userApiKey: userApiKey,
    );
  }
}
