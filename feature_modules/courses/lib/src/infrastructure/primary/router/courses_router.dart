import 'package:core_routes/courses.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/model/person_model.dart';
import '../../../domain/model/session_model.dart';
import '../../../presentation/view/content_details_page.dart';
import '../../../presentation/view/course_details_page.dart';
import '../../../presentation/view/courses_faculty_overview.dart';
import '../../../presentation/view/courses_overview.dart';
import '../../../presentation/view/courses_search_page.dart';
import '../../../presentation/view/persons_details_page.dart';
import '../../../presentation/view/sessions_details_page.dart';

class CoursesRouterImpl extends CoursesRouter {
  @override
  Widget buildOverview(BuildContext context, {required int facultyId}) =>
      CoursesOverview(
        facultyId: facultyId,
      );

  @override
  Widget buildFacultyOverview(BuildContext context) => CoursesFacultyOverview();

  @override
  Widget buildDetails(
    BuildContext context, {
    required int facultyId,
    required int courseId,
    required String name,
    required String language,
    String? degree,
    int? sws,
  }) =>
      CourseDetailsPage(
        facultyId: facultyId,
        courseId: courseId,
        name: name,
        language: language,
        degree: degree,
        sws: sws,
      );

  @override
  Widget buildSessionsDetails(BuildContext context, List<RSessionModel> $extra) =>
      SessionsDetailsPage(sessions: $extra as List<SessionModel>);

  @override
  Widget buildPersonsDetails(BuildContext context, List<RPersonModel> $extra) =>
      PersonsDetailsPage(persons: $extra as List<PersonModel>);

  @override
  Widget buildContentDetails(
    BuildContext context, {
    required int facultyId,
    required int courseId,
    required String name,
    required String language,
    required String content,
    String? degree,
    int? sws,
  }) =>
      ContentDetailsPage(content: content);

  @override
  Widget buildSearch(BuildContext context, {required int facultyId}) =>
      CoursesSearchPage(facultyId: facultyId);
}
