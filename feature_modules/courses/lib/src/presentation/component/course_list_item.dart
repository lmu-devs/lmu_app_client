import 'package:core/components.dart';
import 'package:flutter/material.dart';

import '../../domain/model/course_model.dart';

class CourseListItem extends StatelessWidget {
  const CourseListItem({
    super.key,
    required this.course,
    required this.onTap,
  });

  final CourseModel course;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return LmuListItem.action(
      title: course.name,
      subtitle: course.type,
      actionType: LmuListItemAction.chevron,
      onTap: onTap,
    );
  }
}
