import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LectureLecturers extends StatelessWidget {
  const LectureLecturers({
    super.key,
    required this.lectureTitle,
  });

  final String lectureTitle;

  @override
  Widget build(BuildContext context) {
    final locals = context.locals.lectures;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: locals.lecturersTitle,
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
                  title: 'Prof. Dr. Max Mustermann',
                  trailingArea: Icon(LucideIcons.chevron_right, size: 20),
                  onTap: () {
                    // TODO: Navigate to people feature
                  },
                ),
                LmuListItem.base(
                  title: 'Dr. Anna Schmidt',
                  trailingArea: Icon(LucideIcons.chevron_right, size: 20),
                  onTap: () {
                    // TODO: Navigate to people feature
                  },
                ),
                LmuListItem.base(
                  title: 'M.Sc. Tom Weber',
                  trailingArea: Icon(LucideIcons.chevron_right, size: 20),
                  onTap: () {
                    // TODO: Navigate to people feature
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
