// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<StatefulShellBranch> get $appRoutes => [
      $cinemaMainRoute,
    ];

StatefulShellBranch get $cinemaMainRoute => StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/cinema',
          factory: $CinemaMainRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'cinema_details',
              factory: $CinemaDetailsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'screening_details',
              factory: $ScreeningDetailsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'screenings_history',
              factory: $ScreeningsHistoryRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $CinemaMainRouteExtension on CinemaMainRoute {
  static CinemaMainRoute _fromState(GoRouterState state) => const CinemaMainRoute();

  String get location => GoRouteData.$location(
        '/cinema',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CinemaDetailsRouteExtension on CinemaDetailsRoute {
  static CinemaDetailsRoute _fromState(GoRouterState state) => CinemaDetailsRoute(
        state.extra as CinemaDetailsData,
      );

  String get location => GoRouteData.$location(
        '/cinema/cinema_details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $ScreeningDetailsRouteExtension on ScreeningDetailsRoute {
  static ScreeningDetailsRoute _fromState(GoRouterState state) => ScreeningDetailsRoute(
        state.extra as ScreeningDetailsData,
      );

  String get location => GoRouteData.$location(
        '/cinema/screening_details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $ScreeningsHistoryRouteExtension on ScreeningsHistoryRoute {
  static ScreeningsHistoryRoute _fromState(GoRouterState state) => ScreeningsHistoryRoute(
        state.extra as ScreeningsHistoryData,
      );

  String get location => GoRouteData.$location(
        '/cinema/screenings_history',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}
