import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LectureLinks extends StatelessWidget {
  const LectureLinks({
    super.key,
    required this.lectureTitle,
  });

  final String lectureTitle;

  @override
  Widget build(BuildContext context) {
    final locals = context.locals.lectures;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: locals.linksTitle,
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
                  subtitle: locals.linksMoodleCourse,
                  trailingTitle: 'moodle.lmu.de/natural-computing',
                  trailingArea: Icon(LucideIcons.external_link, size: 20),
                  onTap: () {},
                ),
                LmuListItem.base(
                  subtitle: locals.linksLsfEvent,
                  trailingTitle: 'lsf.lmu.de/event/12345',
                  trailingArea: Icon(LucideIcons.external_link, size: 20),
                  onTap: () {},
                ),
                LmuListItem.base(
                  subtitle: locals.linksSlides,
                  trailingTitle: 'slides.lmu.de/natural-computing',
                  trailingArea: Icon(LucideIcons.external_link, size: 20),
                  onTap: () {},
                ),
                LmuListItem.base(
                  subtitle: locals.linksExercises,
                  trailingTitle: 'exercises.lmu.de/natural-computing',
                  trailingArea: Icon(LucideIcons.external_link, size: 20),
                  onTap: () {},
                ),
                LmuListItem.base(
                  subtitle: locals.linksForum,
                  trailingTitle: 'forum.lmu.de/natural-computing',
                  trailingArea: Icon(LucideIcons.external_link, size: 20),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(locals.linksUsefulResources),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(
              '• ${locals.linksResources1}\n'
              '• ${locals.linksResources2}\n'
              '• ${locals.linksResources3}\n'
              '• ${locals.linksResources4}',
            ),
          ],
        ),
      ),
    );
  }
}
