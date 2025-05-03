import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../models/router_wishlist_model.dart';
import '../router/wishlist_router.dart';

WishlistRouter get _router => GetIt.I.get<WishlistRouter>();

class WishlistData extends StatefulShellBranchData {
  const WishlistData();
}

class WishlistMainRoute extends GoRouteData {
  const WishlistMainRoute();

  static const String path = '/wishlist';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class WishlistDetailsRoute extends GoRouteData {
  const WishlistDetailsRoute(this.$extra);

  final RWishlistModel $extra;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, $extra);
}
