import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'home_routes.g.dart';

void init() {
  GetIt.I.registerLazySingleton<LinksRouteTet>(() => LinksRouteTestImpl());
}

class LinksRoute extends GoRouteData {
  const LinksRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => GetIt.I<LinksRouteTet>().buildMain(context, state);
}

class LinksRouteTestImpl extends LinksRouteTet {
  @override
  Widget buildMain(BuildContext context, GoRouterState state) {
    return const LinksPage();
  }
}

abstract class LinksRouteTet {
  Widget buildMain(BuildContext context, GoRouterState state);
}

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
