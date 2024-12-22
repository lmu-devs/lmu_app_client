// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<StatefulShellBranch> get $appRoutes => [
      $wishlistData,
    ];

StatefulShellBranch get $wishlistData => StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/wishlist',
          factory: $WishlistMainRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'details',
              factory: $WishlistDetailsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $WishlistMainRouteExtension on WishlistMainRoute {
  static WishlistMainRoute _fromState(GoRouterState state) =>
      const WishlistMainRoute();

  String get location => GoRouteData.$location(
        '/wishlist',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WishlistDetailsRouteExtension on WishlistDetailsRoute {
  static WishlistDetailsRoute _fromState(GoRouterState state) =>
      WishlistDetailsRoute(
        state.extra as WishlistModel,
      );

  String get location => GoRouteData.$location(
        '/wishlist/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
