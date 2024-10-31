import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'mensa_routes.g.dart';

@TypedStatefulShellBranch<MensaData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<MensaMainRoute>(
      path: '/mensa',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<MensaDetailsRoute>(
          path: 'details',
        ),
      ],
    ),
  ],
)
class MensaData extends StatefulShellBranchData {
  const MensaData();
}

class MensaMainRoute extends GoRouteData {
  const MensaMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MensaMainPage();
}

class MensaDetailsRoute extends GoRouteData {
  const MensaDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MensaDetailsPage();
}
