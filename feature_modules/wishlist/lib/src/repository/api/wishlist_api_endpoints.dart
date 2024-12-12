class WishlistApiEndpoints {
  static const String _baseUrl = "https://api.lmu-dev.org";

  static const String _version = '/v1';

  static const String _wishlistRoute = '/wishlists';

  static String getWishlistModels() {
    return '$_baseUrl$_version$_wishlistRoute';
  }
}
