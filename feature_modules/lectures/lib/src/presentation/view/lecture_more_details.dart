import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

class LectureMoreDetails extends StatelessWidget {
  const LectureMoreDetails({
    super.key,
    required this.lectureTitle,
  });

  final String lectureTitle;

  @override
  Widget build(BuildContext context) {
    final locals = context.locals.lectures;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: locals.moreDetailsTitle,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: lectureTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  subtitle: locals.moreDetailsLanguage,
                  trailingTitle: locals.moreDetailsEnglish,
                  maximizeTrailingTitleArea: true,
                ),
                LmuListItem.base(
                  subtitle: locals.moreDetailsParticipants,
                  trailingTitle: locals.moreDetailsMaxParticipants('80'),
                  maximizeTrailingTitleArea: true,
                ),
                LmuListItem.base(
                  subtitle: locals.moreDetailsRegistration,
                  trailingTitle: locals.moreDetailsUntil('15.10.2024'),
                  maximizeTrailingTitleArea: true,
                ),
                LmuListItem.base(
                  subtitle: locals.moreDetailsExamRegistration,
                  trailingTitle: locals.moreDetailsUntil('30.11.2024'),
                  maximizeTrailingTitleArea: true,
                ),
                LmuListItem.base(
                  subtitle: locals.moreDetailsExamDate,
                  trailingTitle: '15.02.2025',
                  maximizeTrailingTitleArea: true,
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(locals.moreDetailsLiterature),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(
              '• ${locals.moreDetailsLiterature1}\n'
              '• ${locals.moreDetailsLiterature2}\n'
              '• ${locals.moreDetailsLiterature3}',
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(locals.moreDetailsNotes),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(locals.moreDetailsNotesText),
          ],
        ),
      ),
    );
  }
}
