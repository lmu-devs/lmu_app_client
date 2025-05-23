import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/{{feature_name.snakeCase()}}_router.dart';

{{feature_name.pascalCase()}}Router get _router => GetIt.I.get<{{feature_name.pascalCase()}}Router>();

class {{feature_name.pascalCase()}}MainRoute extends GoRouteData {
  const {{feature_name.pascalCase()}}MainRoute();

  static const String path = '{{feature_name.snakeCase()}}';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}