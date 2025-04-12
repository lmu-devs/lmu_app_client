// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

StatefulShellBranch get $exploreData => StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/explore',
          factory: $ExploreMainRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'search',
              factory: $ExploreSearchRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'mensa',
              factory: $ExploreMensaRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'building',
              factory: $ExploreBuildingRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'cinema',
              factory: $ExploreCinemaRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $ExploreMainRouteExtension on ExploreMainRoute {
  static ExploreMainRoute _fromState(GoRouterState state) => const ExploreMainRoute();

  String get location => GoRouteData.$location(
        '/explore',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExploreSearchRouteExtension on ExploreSearchRoute {
  static ExploreSearchRoute _fromState(GoRouterState state) => const ExploreSearchRoute();

  String get location => GoRouteData.$location(
        '/explore/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExploreMensaRouteExtension on ExploreMensaRoute {
  static ExploreMensaRoute _fromState(GoRouterState state) => ExploreMensaRoute(
        state.uri.queryParameters['mensa-id']!,
      );

  String get location => GoRouteData.$location(
        '/explore/mensa',
        queryParams: {
          'mensa-id': mensaId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExploreBuildingRouteExtension on ExploreBuildingRoute {
  static ExploreBuildingRoute _fromState(GoRouterState state) => ExploreBuildingRoute(
        state.uri.queryParameters['building-id']!,
      );

  String get location => GoRouteData.$location(
        '/explore/building',
        queryParams: {
          'building-id': buildingId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExploreCinemaRouteExtension on ExploreCinemaRoute {
  static ExploreCinemaRoute _fromState(GoRouterState state) => ExploreCinemaRoute(
        state.uri.queryParameters['cinema-id']!,
      );

  String get location => GoRouteData.$location(
        '/explore/cinema',
        queryParams: {
          'cinema-id': cinemaId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
