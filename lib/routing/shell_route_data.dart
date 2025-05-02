import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import 'package:wishlist/wishlist.dart';

import 'scaffold_with_nav_bar.dart';

RouteBase get $shellRouteData => StatefulShellRouteData.$route(
      restorationScopeId: ShellRouteData.$restorationScopeId,
      navigatorContainerBuilder: ShellRouteData.$navigatorContainerBuilder,
      factory: (_) => const ShellRouteData(),
      branches: [
        $homeData,
        $wishlistData,
      ],
    );

class ShellRouteData extends StatefulShellRouteData {
  const ShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      navigationShell;

  static const String $restorationScopeId = 'restorationScopeId';

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) =>
      ScaffoldWithNavBar(
        navigationShell: navigationShell,
        children: children,
      );
}
