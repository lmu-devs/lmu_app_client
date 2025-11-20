import 'package:core_routes/courses.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/course_details_page.dart';
import '../../../presentation/view/courses_faculty_overview.dart';
import '../../../presentation/view/courses_overview.dart';
import '../../../presentation/view/courses_search_page.dart';

class CoursesRouterImpl extends CoursesRouter {
  @override
  Widget buildOverview(BuildContext context, {required int facultyId}) =>
      CoursesOverview(
        facultyId: facultyId,
      );

  @override
  Widget buildFacultyOverview(BuildContext context) => CoursesFacultyOverview();

  @override
  Widget buildDetails(BuildContext context,
          {required int facultyId, required int courseId, required String courseName}) =>
      CourseDetailsPage(
        courseId: courseId,
        courseName: courseName,
      );

  @override
  Widget buildSearch(BuildContext context, {required int facultyId}) =>
      CoursesSearchPage(
        facultyId: facultyId,
      );
}
