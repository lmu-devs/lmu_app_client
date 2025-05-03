import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/timeline_router.dart';

TimelineRouter get _router => GetIt.I.get<TimelineRouter>();

class TimelineMainRoute extends GoRouteData {
  const TimelineMainRoute();

  static const String path = 'timeline';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}
