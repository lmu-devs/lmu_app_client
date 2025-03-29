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
        GoRouteData.$route(
          path: 'info',
          factory: $SportsInfoRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'tickets',
          factory: $SportsTicketRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'search',
          factory: $SportsSearchRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'searchDetails',
              factory: $SportsSearchDetailsRouteExtension._fromState,
            ),
          ],
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
        state.extra as SportsType,
      );

  String get location => GoRouteData.$location(
        '/home/sports/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $SportsInfoRouteExtension on SportsInfoRoute {
  static SportsInfoRoute _fromState(GoRouterState state) => const SportsInfoRoute();

  String get location => GoRouteData.$location(
        '/home/sports/info',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsTicketRouteExtension on SportsTicketRoute {
  static SportsTicketRoute _fromState(GoRouterState state) => const SportsTicketRoute();

  String get location => GoRouteData.$location(
        '/home/sports/tickets',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsSearchRouteExtension on SportsSearchRoute {
  static SportsSearchRoute _fromState(GoRouterState state) => const SportsSearchRoute();

  String get location => GoRouteData.$location(
        '/home/sports/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsSearchDetailsRouteExtension on SportsSearchDetailsRoute {
  static SportsSearchDetailsRoute _fromState(GoRouterState state) => SportsSearchDetailsRoute(
        state.extra as SportsType,
      );

  String get location => GoRouteData.$location(
        '/home/sports/search/searchDetails',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}
