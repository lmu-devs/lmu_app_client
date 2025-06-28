import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/settings_router.dart';

SettingsRouter get _router => GetIt.I.get<SettingsRouter>();

class SettingsMainRoute extends GoRouteData {
  const SettingsMainRoute();

  static const String path = 'settings';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class SettingsAppearanceRoute extends GoRouteData {
  const SettingsAppearanceRoute();

  static const String path = 'appearance';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildAppearance(context);
}

class SettingsAccountRoute extends GoRouteData {
  const SettingsAccountRoute();

  static const String path = 'account';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildAccount(context);
}

class SettingsLanguageRoute extends GoRouteData {
  const SettingsLanguageRoute();

  static const String path = 'language';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildLanguage(context);
}

class SettingsAnalyticsRoute extends GoRouteData {
  const SettingsAnalyticsRoute();

  static const String path = 'analytics';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildAnalytics(context);
}

class SettingsLicenceRoute extends GoRouteData {
  const SettingsLicenceRoute();

  static const String path = 'license';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildLicense(context);
}

class SettingsDebugRoute extends GoRouteData {
  const SettingsDebugRoute();

  static const String path = 'debug';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDebug(context);
}
