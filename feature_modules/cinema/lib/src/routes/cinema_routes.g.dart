// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $cinemaMainRoute,
    ];

RouteBase get $cinemaMainRoute => GoRouteData.$route(
      path: '/cinema',
      factory: $CinemaMainRouteExtension._fromState,
    );

extension $CinemaMainRouteExtension on CinemaMainRoute {
  static CinemaMainRoute _fromState(GoRouterState state) =>
      const CinemaMainRoute();

  String get location => GoRouteData.$location(
        '/cinema',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
