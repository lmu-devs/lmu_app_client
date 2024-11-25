import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'settings_routes.g.dart';

@TypedStatefulShellBranch<SettingsData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<SettingsMainRoute>(
      path: '/settings',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<SettingsApperanceRoute>(
          path: 'apperance',
        ),
        TypedGoRoute<SettingsLanguageRoute>(
          path: 'language',
        ),
        TypedGoRoute<SettingsLicenceRoute>(
          path: 'licence',
        ),
        TypedGoRoute<SettingsAccountRoute>(
          path: 'account',
        ),
      ],
    ),
  ],
)
class SettingsData extends StatefulShellBranchData {
  const SettingsData();
}

class SettingsMainRoute extends GoRouteData {
  const SettingsMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsMainPage();
}

class SettingsApperanceRoute extends GoRouteData {
  const SettingsApperanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsApperancePage();
}
class SettingsAccountRoute extends GoRouteData {
  const SettingsAccountRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsAccountPage();
}

class SettingsLanguageRoute extends GoRouteData {
  const SettingsLanguageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Placeholder();
}

class SettingsLicenceRoute extends GoRouteData {
  const SettingsLicenceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsLicencePage();
}
