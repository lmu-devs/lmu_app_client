import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';
import '../pages/settings_language_page.dart';

part 'settings_routes.g.dart';

@TypedGoRoute<SettingsMainRoute>(
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
    TypedGoRoute<SettingsDebugRoute>(
      path: 'debug',
    ),
  ],
)
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
  Widget build(BuildContext context, GoRouterState state) => const SettingsLanguagePage();
}

class SettingsLicenceRoute extends GoRouteData {
  const SettingsLicenceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsLicencePage();
}

class SettingsDebugRoute extends GoRouteData {
  const SettingsDebugRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsDebugPage();
}
