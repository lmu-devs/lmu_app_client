import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/courses_router.dart';

CoursesRouter get _router => GetIt.I.get<CoursesRouter>();

class CoursesOverviewRoute extends GoRouteData {

  const CoursesOverviewRoute({required this.facultyId});
  final int facultyId;

  static const String path = 'courses';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _router.buildOverview(context, facultyId: facultyId);
  }
}

class CoursesFacultyOverviewRoute extends GoRouteData {
  const CoursesFacultyOverviewRoute();

  static const String path = 'courses-faculties';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildFacultyOverview(context);
}

class CourseDetailsRoute extends GoRouteData {

  const CourseDetailsRoute({required this.facultyId, required this.courseId});
  final int facultyId;
  final int courseId;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _router.buildDetails(context, facultyId: facultyId, courseId: courseId);
  }
}

class CoursesSearchRoute extends GoRouteData {

  const CoursesSearchRoute({required this.facultyId});
  final int facultyId;

  static const String path = 'courses-search';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _router.buildSearch(context, facultyId: facultyId);
  }
}
