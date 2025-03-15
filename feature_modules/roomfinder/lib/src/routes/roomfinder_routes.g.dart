// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $roomfinderMainRoute,
    ];

RouteBase get $roomfinderMainRoute => GoRouteData.$route(
      path: '/roomfinder',
      factory: $RoomfinderMainRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'buildingDetails',
          factory: $RoomfinderBuildingDetailsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'buildingRoomDetails',
              factory: $RoomfinderBuildingRoomDetailsRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'roomDetails',
          factory: $RoomfinderRoomDetailsRouteExtension._fromState,
        ),
      ],
    );

extension $RoomfinderMainRouteExtension on RoomfinderMainRoute {
  static RoomfinderMainRoute _fromState(GoRouterState state) => const RoomfinderMainRoute();

  String get location => GoRouteData.$location(
        '/home/roomfinder',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RoomfinderBuildingDetailsRouteExtension on RoomfinderBuildingDetailsRoute {
  static RoomfinderBuildingDetailsRoute _fromState(GoRouterState state) => RoomfinderBuildingDetailsRoute(
        state.uri.queryParameters['building-id']!,
      );

  String get location => GoRouteData.$location(
        '/home/roomfinder/buildingDetails',
        queryParams: {
          'building-id': buildingId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RoomfinderBuildingRoomDetailsRouteExtension on RoomfinderBuildingRoomDetailsRoute {
  static RoomfinderBuildingRoomDetailsRoute _fromState(GoRouterState state) => RoomfinderBuildingRoomDetailsRoute(
        state.extra as RoomfinderRoom,
      );

  String get location => GoRouteData.$location(
        '/home/roomfinder/buildingDetails/buildingRoomDetails',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $RoomfinderRoomDetailsRouteExtension on RoomfinderRoomDetailsRoute {
  static RoomfinderRoomDetailsRoute _fromState(GoRouterState state) => RoomfinderRoomDetailsRoute(
        state.extra as RoomfinderRoom,
      );

  String get location => GoRouteData.$location(
        '/home/roomfinder/roomDetails',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}
