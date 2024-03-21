class RouteNames {
  static const home = '/';
  static const mensa = '/mensa';
  static const mensaDetails = '/mensa/details';
}

extension RouteExtension on String {
  String get asSubroute {
    final parts = split('/');
    return parts.isNotEmpty ? parts.last : '';
  }
}
