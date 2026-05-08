import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/launch_flow_router.dart';

LaunchFlowRouter get _router => GetIt.I.get<LaunchFlowRouter>();

class LaunchFlowWelcomeRoute extends GoRouteData {
  const LaunchFlowWelcomeRoute();

  static const String path = '/app/welcome';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildWelcome(context);
}

class LaunchFlowAppUpdateRoute extends GoRouteData {
  const LaunchFlowAppUpdateRoute();

  static const String path = '/app/app_update';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildAppUpdate(context);
}

class LaunchFlowReleaseNotesRoute extends GoRouteData {
  const LaunchFlowReleaseNotesRoute();

  static const String path = '/app/release_notes';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildReleaseNotes(context);
}

class LaunchFlowFacultySelectionRoute extends GoRouteData {
  const LaunchFlowFacultySelectionRoute();

  static const String path = '/app/faculty_selection';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildFacultySelection(context);
}

class LaunchFlowPermissionsOnboardingRoute extends GoRouteData {
  const LaunchFlowPermissionsOnboardingRoute();

  static const String path = '/app/permissions_onboarding';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildPermissionsOnboarding(context);
}
