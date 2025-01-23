// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

RouteBase get $sportsMainRoute => GoRouteData.$route(
      path: 'sports',
      factory: $SportsMainRouteExtension._fromState,
      routes: [],
    );

extension $SportsMainRouteExtension on SportsMainRoute {
  static SportsMainRoute _fromState(GoRouterState state) => const  SportsMainRoute();

  String get location => GoRouteData.$location(
        '/sports',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
