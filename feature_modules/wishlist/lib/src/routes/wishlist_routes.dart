import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';
import '../pages/wishlist_details_page.dart';
import '../repository/api/api.dart';

part 'wishlist_routes.g.dart';

@TypedStatefulShellBranch<WishlistData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<WishlistMainRoute>(
      path: '/wishlist',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<WishlistDetailsRoute>(
          path: '/details',
        ),
      ],
    ),
  ],
)
class WishlistData extends StatefulShellBranchData {
  const WishlistData();
}

class WishlistMainRoute extends GoRouteData {
  const WishlistMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const WishlistPage();
}

class WishlistDetailsRoute extends GoRouteData {
  const WishlistDetailsRoute(this.$extra);

  final WishlistModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => WishlistDetailsPage(
        wishlistModel: $extra,
      );
}
