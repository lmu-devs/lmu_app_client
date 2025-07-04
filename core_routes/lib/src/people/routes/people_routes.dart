import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/people_router.dart';

PeopleRouter get _router => GetIt.I.get<PeopleRouter>();

class PeopleOverviewRoute extends GoRouteData {
  final int facultyId;

  const PeopleOverviewRoute({required this.facultyId});

  static const String path = 'people';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _router.buildOverview(context, facultyId: facultyId);
  }
}

class PeopleFacultyOverviewRoute extends GoRouteData {
  const PeopleFacultyOverviewRoute();

  static const String path = 'people-faculties';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildFacultyOverview(context);
}
