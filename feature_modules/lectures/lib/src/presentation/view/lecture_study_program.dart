import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

class LectureStudyProgram extends StatelessWidget {
  const LectureStudyProgram({
    super.key,
    required this.lectureTitle,
  });

  final String lectureTitle;

  @override
  Widget build(BuildContext context) {
    final locals = context.locals.lectures;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: locals.studyProgramTitle,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: lectureTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.h3(locals.studyProgramFacultyMathInfo),
            const SizedBox(height: LmuSizes.size_16),
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  subtitle: locals.studyProgramComputerScience,
                  trailingTitle: locals.studyProgramMaster,
                  maximizeTrailingTitleArea: true,
                ),
                LmuListItem.base(
                  subtitle: locals.studyProgramMediaInformatics,
                  trailingTitle: locals.studyProgramMaster,
                  maximizeTrailingTitleArea: true,
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(locals.studyProgramFacultyPhysics),
            const SizedBox(height: LmuSizes.size_16),
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  subtitle: locals.studyProgramPhysics,
                  trailingTitle: locals.studyProgramMaster,
                  maximizeTrailingTitleArea: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
