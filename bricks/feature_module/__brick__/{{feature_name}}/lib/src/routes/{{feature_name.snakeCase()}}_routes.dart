import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part '{{feature_name.snakeCase()}}_routes.g.dart';

@TypedGoRoute<{{feature_name.pascalCase()}}MainRoute>(
  path: '/{{feature_name.snakeCase()}}',
  routes: <TypedGoRoute<GoRouteData>>[],
)

class {{feature_name.pascalCase()}}MainRoute extends GoRouteData {
  const {{feature_name.pascalCase()}}MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const {{feature_name.pascalCase()}}Page();
}
