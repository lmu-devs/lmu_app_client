class WishlistApiEndpoints {
  static const String _baseUrl = "https://api.lmu-dev.org";

  static const String _version = '/v1';

  static const String _wishlistRoute = '/wishlists';

  static const String _toggleLike = '/toggle-like';

  static String getWishlistModels({int? id}) {
    final query = id == null ? '' : '?id=$id';
    return '$_baseUrl$_version$_wishlistRoute$query';
  }

  static String toggleWishlistLike(int id) {
    return '$_baseUrl$_version$_wishlistRoute$_toggleLike?id=$id';
  }
}
