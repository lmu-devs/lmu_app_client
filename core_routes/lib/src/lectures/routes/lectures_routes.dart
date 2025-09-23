import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/lectures_router.dart';

LecturesRouter get _router => GetIt.I.get<LecturesRouter>();

class LecturesMainRoute extends GoRouteData {
  const LecturesMainRoute();

  static const String path = 'lectures';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class LectureListRoute extends GoRouteData {
  const LectureListRoute({
    required this.facultyId,
  });

  final int facultyId;

  static const String path = 'lecture-list';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildLectureList(context, {
        'facultyId': facultyId,
      });
}

class LectureDetailRoute extends GoRouteData {
  const LectureDetailRoute({
    required this.lectureId,
    required this.lectureTitle,
  });

  final String lectureId;
  final String lectureTitle;

  static const String path = 'lecture-detail';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildLectureDetail(context, {
        'lectureId': lectureId,
        'lectureTitle': lectureTitle,
      });
}
