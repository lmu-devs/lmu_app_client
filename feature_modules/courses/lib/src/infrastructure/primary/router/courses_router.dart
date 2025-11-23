import 'package:core_routes/courses.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/model/person_model.dart';
import '../../../presentation/view/content_details_page.dart';
import '../../../presentation/view/course_details_page.dart';
import '../../../presentation/view/courses_faculty_overview.dart';
import '../../../presentation/view/courses_overview.dart';
import '../../../presentation/view/courses_search_page.dart';
import '../../../presentation/view/persons_details_page.dart';
import 'person_details_data.dart';

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
  Widget buildPersonsDetails(BuildContext context, RPersonDetailsData $extra) =>
      PersonsDetailsPage(personDetailsData: $extra as PersonDetailsData);

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
