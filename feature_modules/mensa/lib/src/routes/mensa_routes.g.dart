// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

StatefulShellBranch get $mensaData => StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/mensa',
          factory: $MensaMainRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'details',
              factory: $MensaDetailsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'search',
              factory: $MensaSearchRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'searchDetails',
                  factory: $MensaSearchDetailsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MensaMainRouteExtension on MensaMainRoute {
  static MensaMainRoute _fromState(GoRouterState state) => const MensaMainRoute();

  String get location => GoRouteData.$location(
        '/mensa',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MensaDetailsRouteExtension on MensaDetailsRoute {
  static MensaDetailsRoute _fromState(GoRouterState state) => MensaDetailsRoute(
        state.extra as MensaModel,
      );

  String get location => GoRouteData.$location(
        '/mensa/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $MensaSearchRouteExtension on MensaSearchRoute {
  static MensaSearchRoute _fromState(GoRouterState state) => const MensaSearchRoute();

  String get location => GoRouteData.$location(
        '/mensa/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MensaSearchDetailsRouteExtension on MensaSearchDetailsRoute {
  static MensaSearchDetailsRoute _fromState(GoRouterState state) => MensaSearchDetailsRoute(
        state.extra as MensaModel,
      );

  String get location => GoRouteData.$location(
        '/mensa/search/searchDetails',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}
