import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../component/lectures_card.dart';
import 'lecture_detail_page.dart';

class LectureListPage extends StatelessWidget {
  final String facultyId;
  final String facultyName;

  const LectureListPage({
    required this.facultyId,
    required this.facultyName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: 'Vorlesungen',
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: facultyName),
            const SizedBox(height: LmuSizes.size_16),
            Column(
              children: [
                LecturesCard(
                  title: 'Einführung in die Medieninformatik',
                  tags: ['3 ECTS', 'Mi 10:00 – 12:00', 'Raum A001'],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LectureDetailPage(title: 'Einfürhung in die Medieninformatik'),
                      ),
                    );
                  },
                ),
                LecturesCard(
                  title: 'Grundlagen der Programmierung',
                  tags: ['6 ECTS', 'Do 14:00 – 16:00', 'Raum B102'],
                  onTap: () {
                    // Navigate or show details
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
