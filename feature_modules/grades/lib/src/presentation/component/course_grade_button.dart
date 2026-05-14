import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/course_grade_button_driver.dart';

class CourseGradeButton extends DrivableWidget<CourseGradeButtonDriver> {
  CourseGradeButton({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  final int courseId;
  final String courseName;

  @override
  Widget build(BuildContext context) {
    return LmuButton(
      title: driver.buttonTitle,
      leadingIcon: driver.buttonIcon,
      emphasis: ButtonEmphasis.secondary,
      onTap: () => driver.onTap(context),
    );
  }

  @override
  WidgetDriverProvider<CourseGradeButtonDriver> get driverProvider => $CourseGradeButtonDriverProvider(
        courseId: courseId,
        courseName: courseName,
      );
}
