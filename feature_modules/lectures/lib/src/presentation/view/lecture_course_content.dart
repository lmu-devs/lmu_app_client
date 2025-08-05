import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

class LectureCourseContent extends StatelessWidget {
  const LectureCourseContent({
    super.key,
    required this.lectureTitle,
  });

  final String lectureTitle;

  @override
  Widget build(BuildContext context) {
    final locals = context.locals.lectures;
    
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: locals.courseContentTitle,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: lectureTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.h3(locals.contentTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(locals.courseContentDescription),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(locals.courseContentObjectives),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(
              '• ${locals.courseContentObjectives1}\n'
              '• ${locals.courseContentObjectives2}\n'
              '• ${locals.courseContentObjectives3}\n'
              '• ${locals.courseContentObjectives4}',
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(locals.courseContentPrerequisites),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(locals.courseContentPrerequisitesText),
          ],
        ),
      ),
    );
  }
}
