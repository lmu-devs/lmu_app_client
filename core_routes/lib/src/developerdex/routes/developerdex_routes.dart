import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/developerdex_router.dart';

DeveloperdexRouter get _router => GetIt.I.get<DeveloperdexRouter>();

class DeveloperdexMainRoute extends GoRouteData {
  const DeveloperdexMainRoute();

  static const String path = 'developerdex';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}
