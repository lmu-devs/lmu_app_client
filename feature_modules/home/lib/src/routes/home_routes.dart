import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'home_routes.g.dart';

@TypedStatefulShellBranch<HomeData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeMainRoute>(
      path: '/home',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<LinksRoute>(
          path: '/links',
        ),
        TypedGoRoute<BenefitsRoute>(
          path: '/benefits',
        ),
      ],
    ),
  ],
)
class HomeData extends StatefulShellBranchData {
  const HomeData();
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

class BenefitsRoute extends GoRouteData {
  const BenefitsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BenefitsPage();
}
