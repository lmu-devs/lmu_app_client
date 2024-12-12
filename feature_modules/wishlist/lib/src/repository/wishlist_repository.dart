import 'api/models/wishlist_model.dart';
import 'api/wishlist_api_client.dart';

abstract class WishlistRepository {
  Future<List<WishlistModel>> getWishlistEntries();
}

/// WishlistRepository implementation for fetching wishlist data from the API
class ConnectedWishlistRepository implements WishlistRepository {
  ConnectedWishlistRepository({
    required this.wishlistApiClient,
  });

  final WishlistApiClient wishlistApiClient;

  /// Function to fetch mensa models from the API
  @override
  Future<List<WishlistModel>> getWishlistEntries() async {
    try {
      final wishlistEntries = await wishlistApiClient.getWishlistModels();
      return wishlistEntries;
    } catch (e) {
      rethrow;
    }
  }
}
