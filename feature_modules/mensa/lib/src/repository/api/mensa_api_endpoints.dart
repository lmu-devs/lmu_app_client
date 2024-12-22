class MensaApiEndpoints {
  static const String _baseUrl = "https://api.lmu-dev.org";

  static const String _version = '/v1';

  static const String _foodRoute = '/food';

  static const String _canteensRoute = '/canteens';
  static const String _menusRoute = '/menus';
  static const String _tasteProfileRoute = '/taste-profile';

  static const String _toggleLike = '/toggle-like';

  static const String _canteenIdQuery = 'canteen_id';

  static String getMensaModels() {
    return '$_baseUrl$_version$_foodRoute$_canteensRoute';
  }

  static String getMenuDayForMensa(String canteenId) {
    return '$_baseUrl$_version$_foodRoute$_menusRoute?$_canteenIdQuery=$canteenId';
  }

  static String getTasteProfile() {
    return '$_baseUrl$_version$_foodRoute$_tasteProfileRoute';
  }

  static String toggleFavoriteMensaId(String canteenId) {
    return '$_baseUrl$_version$_foodRoute$_canteensRoute$_toggleLike?$_canteenIdQuery=$canteenId';
  }
}
