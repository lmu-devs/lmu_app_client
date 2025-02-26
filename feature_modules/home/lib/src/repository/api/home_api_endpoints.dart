class HomeApiEndpoints {
  static const String _homeRoute = '/home';
  static const String _linkRoute = '/link';

  static const String _resourcesRoute = '/resources';
  static const String _benefitsRoute = '/benefits';

  static String getHomeData() {
    return _homeRoute;
  }

  static String getLinks() {
    return '$_linkRoute$_resourcesRoute';
  }

  static String getBenefits() {
    return '$_linkRoute$_benefitsRoute';
  }
}
