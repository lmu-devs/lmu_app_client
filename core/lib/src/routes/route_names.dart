class RouteNames {
  static const home = '/';
  static const mensa = '/mensa';
  static const mensaDetails = '/mensa/details';
  static const wunschkonzert = '/wunschkonzert';
  static const settings = '/settings';
  static const settingsApperance = '/settings/apperance';
}

extension RouteExtension on String {
  String get asSubroute {
    final parts = split('/');
    return parts.isNotEmpty ? parts.last : '';
  }
}
