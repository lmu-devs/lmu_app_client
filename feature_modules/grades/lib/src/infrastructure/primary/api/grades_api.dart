import 'package:flutter/widgets.dart';
import 'package:shared_api/grades.dart';

import '../../../presentation/component/course_grade_button.dart';

class GradesApiImpl extends GradesApi {
  @override
  Widget buildCourseGradeButton(
    BuildContext context, {
    required int courseId,
    required String courseName,
  }) {
    return CourseGradeButton(
      courseId: courseId,
      courseName: courseName,
    );
  }
}
