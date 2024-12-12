import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'wishlist_routes.g.dart';

@TypedStatefulShellBranch<WishlistData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<WishlistMainRoute>(
      path: '/wishlist',
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
