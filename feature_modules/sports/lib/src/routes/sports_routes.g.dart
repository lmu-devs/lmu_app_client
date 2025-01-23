// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $sportsMainRoute,
    ];

RouteBase get $sportsMainRoute => GoRouteData.$route(
      path: '/sports',
      factory: $SportsMainRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'details',
          factory: $SportsDetailsRouteExtension._fromState,
        ),
      ],
    );

extension $SportsMainRouteExtension on SportsMainRoute {
  static SportsMainRoute _fromState(GoRouterState state) => const SportsMainRoute();

  String get location => GoRouteData.$location(
        '/home/sports',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsDetailsRouteExtension on SportsDetailsRoute {
  static SportsDetailsRoute _fromState(GoRouterState state) => SportsDetailsRoute(
        state.extra as SportsModel,
      );

  String get location => GoRouteData.$location(
        '/home/sports/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}
