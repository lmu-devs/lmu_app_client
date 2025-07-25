import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/lectures_router.dart';

LecturesRouter get _router => GetIt.I.get<LecturesRouter>();

class LecturesMainRoute extends GoRouteData {
  const LecturesMainRoute();

  static const String path = 'lectures';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}
