import 'package:core/components.dart';
import 'package:flutter/material.dart';

class LectureListPage extends StatelessWidget {
  const LectureListPage({
    super.key,
    required this.facultyId,
    required this.facultyName,
  });

  final String facultyId;
  final String facultyName;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: facultyName,
        leadingAction: LeadingAction.back,
      ),
      body: const Center(
        child: Text('Lecture list content will go here'),
      ),
    );
  }
}
