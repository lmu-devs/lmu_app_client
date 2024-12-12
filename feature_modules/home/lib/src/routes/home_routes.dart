import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/settings.dart';

import '../pages/pages.dart';

part 'home_routes.g.dart';

@TypedStatefulShellBranch<HomeData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeMainRoute>(
      path: '/home',
    ),
  ],
)
class HomeData extends StatefulShellBranchData {
  const HomeData();
}

class HomeMainRoute extends GoRouteData {
  const HomeMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
