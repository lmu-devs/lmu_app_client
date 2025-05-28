import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/studies_router.dart';

StudiesRouter get _router => GetIt.I.get<StudiesRouter>();

class StudiesRouteData extends StatefulShellBranchData {
  const StudiesRouteData();
}

class StudiesMainRoute extends GoRouteData {
  const StudiesMainRoute();

  static const String path = '/studies';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}
