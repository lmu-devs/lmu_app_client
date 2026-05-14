import 'package:flutter/widgets.dart';

abstract class GradesApi {
  Widget buildCourseGradeButton(
    BuildContext context, {
    required int courseId,
    required String courseName,
  });
}
