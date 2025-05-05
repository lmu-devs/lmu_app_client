// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libraries_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $librariesMainRoute,
];

RouteBase get $librariesMainRoute => GoRouteData.$route(
  path: '/libraries',
  factory: $LibrariesMainRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'library_details',
      factory: $LibraryDetailsRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'search',
      factory: $LibrariesSearchRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'searchDetails',
          factory: $LibrarySearchDetailsRouteExtension._fromState,
        ),
      ],
    ),
  ],
);

extension $LibrariesMainRouteExtension on LibrariesMainRoute {
  static LibrariesMainRoute _fromState(GoRouterState state) =>
      const LibrariesMainRoute();

  String get location => GoRouteData.$location(
    '/home/libraries',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LibraryDetailsRouteExtension on LibraryDetailsRoute {
  static LibraryDetailsRoute _fromState(GoRouterState state) =>
      LibraryDetailsRoute(
        state.extra as LibraryModel,
      );

  String get location => GoRouteData.$location(
    '/home/libraries/library_details',
  );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $LibrariesSearchRouteExtension on LibrariesSearchRoute {
  static LibrariesSearchRoute _fromState(GoRouterState state) =>
      const LibrariesSearchRoute();

  String get location => GoRouteData.$location(
    '/home/libraries/search',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LibrarySearchDetailsRouteExtension on LibrarySearchDetailsRoute {
  static LibrarySearchDetailsRoute _fromState(GoRouterState state) =>
      LibrarySearchDetailsRoute(
        state.extra as LibraryModel,
      );

  String get location => GoRouteData.$location(
    '/home/libraries/search/search_details',
  );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
