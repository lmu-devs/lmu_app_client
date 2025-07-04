import 'package:core/components.dart';
import 'package:flutter/material.dart';

import 'faculty_number_widget.dart';

class FacultyCard extends StatelessWidget {
  const FacultyCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.facultyId,
  });

  final String title;
  final void Function() onTap;
  final int facultyId;

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        title: title,
        onTap: onTap,
        actionType: LmuListItemAction.chevron,
        leadingArea: FacultyNumberWidget(facultyId: facultyId),
      ),
    );
  }
}
