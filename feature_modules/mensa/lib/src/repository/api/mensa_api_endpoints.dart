class MensaApiEndpoints {
  static const String _foodRoute = '/food';

  static const String _canteensRoute = '/canteens';
  static const String _dishesRoute = '/dishes';
  static const String _menusRoute = '/menus';
  static const String _tasteProfileRoute = '/taste-profile';

  static const String _toggleLike = '/toggle-like';

  static const String _canteenIdQuery = 'canteen_id';
  static const String _dishIdQuery = 'dish_id';

  static String getMensaModels() {
    return '$_foodRoute$_canteensRoute';
  }

  static String getMenuDayForMensa(String canteenId) {
    return '$_foodRoute$_menusRoute?$_canteenIdQuery=$canteenId';
  }

  static String getTasteProfile() {
    return '$_foodRoute$_tasteProfileRoute';
  }

  static String toggleFavoriteMensaId(String canteenId) {
    return '$_foodRoute$_canteensRoute$_toggleLike?$_canteenIdQuery=$canteenId';
  }

  static String toggleFavoriteDishId(String dishId) {
    return '$_foodRoute$_dishesRoute$_toggleLike?$_dishIdQuery=$dishId';
  }
}
