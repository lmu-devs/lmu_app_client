import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/roomfinder.dart';
import 'package:shared_api/settings.dart';
import 'package:shared_api/sports.dart';
import 'package:shared_api/timeline.dart';

import '../pages/pages.dart';

part 'home_routes.g.dart';

@TypedStatefulShellBranch<HomeRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeMainRoute>(
      path: '/home',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<LinksRoute>(
          path: '/links',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<LinksSearchRoute>(
              path: '/search',
            ),
          ],
        ),
        TypedGoRoute<BenefitsRoute>(
          path: '/benefits',
        ),
      ],
    ),
  ],
)
class HomeRouteData extends StatefulShellBranchData {
  const HomeRouteData();
}

class HomeMainRoute extends GoRouteData {
  const HomeMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class LinksRoute extends GoRouteData {
  const LinksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LinksPage();
}

class LinksSearchRoute extends GoRouteData {
  const LinksSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LinksSearchPage();
}

class BenefitsRoute extends GoRouteData {
  const BenefitsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BenefitsPage();
}
