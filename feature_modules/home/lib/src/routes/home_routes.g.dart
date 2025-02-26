// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<StatefulShellBranch> get $appRoutes => [
      $homeData,
    ];

StatefulShellBranch get $homeData => StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/home',
          factory: $HomeMainRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: '/links',
              factory: $LinksRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/benefits',
              factory: $BenefitsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeMainRouteExtension on HomeMainRoute {
  static HomeMainRoute _fromState(GoRouterState state) => const HomeMainRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinksRouteExtension on LinksRoute {
  static LinksRoute _fromState(GoRouterState state) => const LinksRoute();

  String get location => GoRouteData.$location(
        '/links',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BenefitsRouteExtension on BenefitsRoute {
  static BenefitsRoute _fromState(GoRouterState state) => const BenefitsRoute();

  String get location => GoRouteData.$location(
        '/benefits',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
