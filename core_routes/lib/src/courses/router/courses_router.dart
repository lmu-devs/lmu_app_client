import 'package:flutter/widgets.dart';

abstract class CoursesRouter {
  Widget buildOverview(BuildContext context, {required int facultyId});
  Widget buildFacultyOverview(BuildContext context);
  Widget buildDetails(BuildContext context, {required int facultyId, required int courseId});
  Widget buildSearch(BuildContext context, {required int facultyId});
}
