import 'package:explore/explore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mensa/mensa.dart';
import 'package:settings/settings.dart';
import 'package:wishlist/wishlist.dart';

import 'scaffold_with_nav_bar.dart';

RouteBase get $shellRouteData => StatefulShellRouteData.$route(
      restorationScopeId: ShellRouteData.$restorationScopeId,
      navigatorContainerBuilder: ShellRouteData.$navigatorContainerBuilder,
      factory: (_) => const ShellRouteData(),
      branches: [
        $mensaData,
        $exploreData,
        $wishlistData,
        $settingsData,
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
