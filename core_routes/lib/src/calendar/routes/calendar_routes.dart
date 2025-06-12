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
