import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/grades_router.dart';

GradesRouter get _router => GetIt.I.get<GradesRouter>();

class GradesMainRoute extends GoRouteData {
  const GradesMainRoute();

  static const String path = 'grades';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}
