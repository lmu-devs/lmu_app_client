// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $timelineMainRoute,
    ];

RouteBase get $timelineMainRoute => GoRouteData.$route(
      path: '/timeline',
      factory: $TimelineMainRouteExtension._fromState,
    );

extension $TimelineMainRouteExtension on TimelineMainRoute {
  static TimelineMainRoute _fromState(GoRouterState state) => const TimelineMainRoute();

  String get location => GoRouteData.$location(
        '/home/timeline',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
