// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

StatefulShellBranch get $mensaData => StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/mensa',
          factory: $SettingsMainRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'details',
              factory: $SettingsDetailsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $SettingsMainRouteExtension on MensaMainRoute {
  static MensaMainRoute _fromState(GoRouterState state) => const MensaMainRoute();

  String get location => GoRouteData.$location(
        '/mensa',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsDetailsRouteExtension on MensaDetailsRoute {
  static MensaDetailsRoute _fromState(GoRouterState state) => const MensaDetailsRoute();

  String get location => GoRouteData.$location(
        '/mensa/details',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
