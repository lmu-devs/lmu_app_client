import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/mensa_search_page.dart';
import '../pages/pages.dart';
import '../repository/api/models/mensa/mensa_model.dart';

part 'mensa_routes.g.dart';

@TypedStatefulShellBranch<MensaData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<MensaMainRoute>(
      path: '/mensa',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<MensaDetailsRoute>(
          path: 'details',
        ),
        TypedGoRoute<MensaSearchRoute>(
          path: 'search',
          routes: [
            TypedGoRoute<MensaSearchDetailsRoute>(
              path: 'searchDetails',
            ),
          ],
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
  Widget build(BuildContext context, GoRouterState state) => const MensaPage();
}

class MensaDetailsRoute extends GoRouteData {
  const MensaDetailsRoute(this.$extra);
  final MensaModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => MensaDetailsPage(mensaModel: $extra);
}

class MensaSearchRoute extends GoRouteData {
  const MensaSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MensaSearchPage();
}

class MensaSearchDetailsRoute extends GoRouteData {
  const MensaSearchDetailsRoute(this.$extra);
  final MensaModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => MensaDetailsPage(mensaModel: $extra);
}
