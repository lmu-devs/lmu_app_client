import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/calendar_router.dart';

CalendarRouter get _router => GetIt.I.get<CalendarRouter>();

class CalendarMainRoute extends GoRouteData {
  const CalendarMainRoute();

  static const String path = 'calendar';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class CalendarTestRoute extends GoRouteData {
  const CalendarTestRoute();

  static const String path = 'calendar/test';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildTestScreen(context);
}

class CalendarSearchRoute extends GoRouteData {
  const CalendarSearchRoute();

  static const String path = 'search';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildSearch(context);
}

class CalendarCreateRoute extends GoRouteData {
  const CalendarCreateRoute();

  static const String path = 'create';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildCreate(context);
}
