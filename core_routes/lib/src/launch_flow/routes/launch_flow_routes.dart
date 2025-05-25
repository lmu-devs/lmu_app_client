import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/launch_flow_router.dart';

LaunchFlowRouter get _router => GetIt.I.get<LaunchFlowRouter>();

class LaunchFlowWelcomeRoute extends GoRouteData {
  const LaunchFlowWelcomeRoute();

  static const String path = '/welcome';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildWelcome(context);
}

class LaunchFlowAppUpdateRoute extends GoRouteData {
  const LaunchFlowAppUpdateRoute();

  static const String path = '/app_update';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildAppUpdate(context);
}
