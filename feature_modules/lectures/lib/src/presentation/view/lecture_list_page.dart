import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/studies.dart';

class LectureListPage extends StatelessWidget {
  const LectureListPage({
    super.key,
    required this.faculty,
  });

  final Faculty faculty;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: faculty.name,
        leadingAction: LeadingAction.back,
      ),
      body: const Center(
        child: Text('Lecture list content will go here'),
      ),
    );
  }
}
