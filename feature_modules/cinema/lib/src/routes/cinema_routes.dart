import 'package:cinema/src/pages/cinema_main.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'cinema_routes.g.dart';

@TypedGoRoute<CinemaMainRoute>(
  path: '/cinema',
  // routes: <TypedGoRoute<GoRouteData>>[
  //   TypedGoRoute<SettingsApperanceRoute>(
  //     path: 'apperance',
  //   ),
  //   TypedGoRoute<SettingsLanguageRoute>(
  //     path: 'language',
  //   ),
  //   TypedGoRoute<SettingsLicenceRoute>(
  //     path: 'licence',
  //   ),
  //   TypedGoRoute<SettingsAccountRoute>(
  //     path: 'account',
  //   ),
  //   TypedGoRoute<SettingsDebugRoute>(
  //     path: 'debug',
  //   ),
  // ],
)
class CinemaMainRoute extends GoRouteData {
  const CinemaMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CinemaMainPage();
}

// class SettingsApperanceRoute extends GoRouteData {
//   const SettingsApperanceRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const SettingsApperancePage();
// }

// class SettingsAccountRoute extends GoRouteData {
//   const SettingsAccountRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const SettingsAccountPage();
// }

// class SettingsLanguageRoute extends GoRouteData {
//   const SettingsLanguageRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const Placeholder();
// }

// class SettingsLicenceRoute extends GoRouteData {
//   const SettingsLicenceRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const SettingsLicencePage();
// }

// class SettingsDebugRoute extends GoRouteData {
//   const SettingsDebugRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const SettingsDebugPage();
// }
