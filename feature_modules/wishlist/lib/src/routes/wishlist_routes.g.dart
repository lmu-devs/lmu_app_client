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
        ),
      ],
    );

extension $WishlistMainRouteExtension on WishlistMainRoute {
  static WishlistMainRoute _fromState(GoRouterState state) => const WishlistMainRoute();

  String get location => GoRouteData.$location(
        '/wishlist',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
