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
