// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<StatefulShellBranch> get $appRoutes => [
      $settingsData,
    ];

StatefulShellBranch get $settingsData => StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',
          factory: $SettingsMainRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'apperance',
              factory: $SettingsApperanceRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'language',
              factory: $SettingsLanguageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'licence',
              factory: $SettingsLicenceRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'account',
              factory: $SettingsAccountRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $SettingsMainRouteExtension on SettingsMainRoute {
  static SettingsMainRoute _fromState(GoRouterState state) =>
      const SettingsMainRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsApperanceRouteExtension on SettingsApperanceRoute {
  static SettingsApperanceRoute _fromState(GoRouterState state) =>
      const SettingsApperanceRoute();

  String get location => GoRouteData.$location(
        '/settings/apperance',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsLanguageRouteExtension on SettingsLanguageRoute {
  static SettingsLanguageRoute _fromState(GoRouterState state) =>
      const SettingsLanguageRoute();

  String get location => GoRouteData.$location(
        '/settings/language',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsLicenceRouteExtension on SettingsLicenceRoute {
  static SettingsLicenceRoute _fromState(GoRouterState state) =>
      const SettingsLicenceRoute();

  String get location => GoRouteData.$location(
        '/settings/licence',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsAccountRouteExtension on SettingsAccountRoute {
  static SettingsAccountRoute _fromState(GoRouterState state) =>
      const SettingsAccountRoute();

  String get location => GoRouteData.$location(
        '/settings/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
