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
  final int facultyId;

  const LectureListRoute({required this.facultyId});

  static const String path = 'lecture-list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _router.buildLectureList(context, facultyId: facultyId);
  }
}
