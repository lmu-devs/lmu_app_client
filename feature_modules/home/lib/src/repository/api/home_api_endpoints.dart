class HomeApiEndpoints {
  static const String _homeRoute = '/home';
  static const String _linkRoute = '/link';

  static const String _resourcesRoute = '/resources';

  static const String _toggleLike = '/toggle-like';
  static const String _idQuery = 'id';

  static String getHomeData() {
    return _homeRoute;
  }

  static String getLinks() {
    return '$_linkRoute$_resourcesRoute';
  }

  static String toggleFavoriteLink(String id) {
    return '$_linkRoute$_resourcesRoute$_toggleLike?$_idQuery=$id';
  }
}
