class WishlistApiEndpoints {
  static const String _wishlistRoute = '/wishlists';

  static const String _toggleLike = '/toggle-like';

  static String getWishlistModels({int? id}) {
    final query = id == null ? '' : '?id=$id';
    return '$_wishlistRoute$query';
  }

  static String toggleWishlistLike(int id) {
    return '$_wishlistRoute$_toggleLike?id=$id';
  }
}
