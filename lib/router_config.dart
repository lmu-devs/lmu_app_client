import 'package:core_routes/config.dart';
import 'package:core_routes/home.dart';
import 'package:core_routes/launch_flow.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/launch_flow.dart';

class LmuRouterConfig {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: $appRoutes,
    initialLocation: const HomeMainRoute().location,
    refreshListenable: GetIt.I.get<LaunchFlowApi>().shouldShowWelcomePageNotifier,
    redirect: (context, state) async {
      if (GetIt.I.get<LaunchFlowApi>().shouldShowWelcomePageNotifier.value == true) {
        return const LaunchFlowWelcomeRoute().location;
      }
      return null;
    },
  );
}
