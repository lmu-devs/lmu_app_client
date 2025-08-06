import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/lecture_course_content_driver.dart';

class LectureCourseContent extends StatelessWidget {
  const LectureCourseContent({
    super.key,
    required this.lectureTitle,
  });

  final String lectureTitle;

  @override
  Widget build(BuildContext context) {
    return _LectureCourseContentDriverProvider(lectureTitle).buildDriver().build(context);
  }
}

class _LectureCourseContentDriverProvider extends WidgetDriverProvider<LectureCourseContentDriver> {
  _LectureCourseContentDriverProvider(this.lectureTitle);

  final String lectureTitle;

  @override
  LectureCourseContentDriver buildDriver() {
    return LectureCourseContentDriver(lectureTitle: lectureTitle);
  }

  @override
  LectureCourseContentDriver buildTestDriver() {
    return LectureCourseContentDriver(lectureTitle: 'Test Course');
  }
}
