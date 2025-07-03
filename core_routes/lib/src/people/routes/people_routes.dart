import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/studies.dart';

import '../router/people_router.dart';

PeopleRouter get _router => GetIt.I.get<PeopleRouter>();

class PeopleOverviewRoute extends GoRouteData {
  final Faculty? faculty;
  const PeopleOverviewRoute({this.faculty});

  static const String path = 'people';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildOverview(context, faculty: faculty);
}

class PeopleFacultyOverviewRoute extends GoRouteData {
  const PeopleFacultyOverviewRoute();

  static const String path = 'faculties';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildFacultyOverview(context);
}
