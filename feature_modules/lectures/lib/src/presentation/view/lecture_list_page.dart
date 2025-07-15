import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: LmuSizes.size_16),
      child: LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: facultyName,
          leadingAction: LeadingAction.back,
          trailingWidgets: [
            // Favorite icon in top right corner
            IconButton(
              icon: Icon(Icons.star_border),
              tooltip: 'Favorit',
              onPressed: () {
                // TODO: handle favorite toggle
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: search, favorite, dropdown, my study
              Row(
                children: [
                  // Search button
                  LmuIconButton(
                    icon: LucideIcons.search,
                    onPressed: () {
                      // TODO: implement search functionality
                    },
                  ),
                  const SizedBox(width: 8),
                  // Favorite button
                  LmuIconButton(
                    icon: LucideIcons.star,
                    onPressed: () {
                      // TODO: implement favorite functionality
                    },
                  ),
                  const SizedBox(width: 8),
                  // Winter 24/25 dropdown button
                  LmuButton(
                    title: 'Winter 24/25',
                    emphasis: ButtonEmphasis.secondary,
                    trailingIcon: Icons.keyboard_arrow_down,
                    onTap: () {
                      // TODO: handle semester change
                    },
                  ),
                  const SizedBox(width: 8),
                  // My Study button
                  LmuButton(
                    title: 'My Study',
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () {
                      // TODO: implement My Study functionality
                    },
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_32),
              // Headline: number of courses with sort button
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '14 Kurse',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // Sort button aligned to the right
                    LmuIconButton(
                      icon: LucideIcons.arrow_up_down,
                      onPressed: () {
                        // TODO: implement sort functionality
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LmuSizes.size_32),
              // Alphabetic grouping and sorting of lectures
              ..._buildGroupedLectureCards(context),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> _lectures = [
  {'title': 'Credit risk modelling'},
  {'title': 'Cybersecurity'},
  {'title': 'Game Development'},
];

List<Widget> _buildGroupedLectureCards(BuildContext context) {
  // Sort lectures alphabetically by title
  final sortedLectures = List<Map<String, String>>.from(_lectures)..sort((a, b) => a['title']!.compareTo(b['title']!));

  // Group by first letter
  Map<String, List<Map<String, String>>> grouped = {};
  for (var lecture in sortedLectures) {
    final letter = lecture['title']![0].toUpperCase();
    grouped.putIfAbsent(letter, () => []).add(lecture);
  }

  // Build widgets
  List<Widget> widgets = [];
  final groupCount = grouped.length;
  int groupIndex = 0;
  grouped.forEach((letter, lectures) {
    widgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 4), // Less space after headline
        child: LmuTileHeadline.base(title: letter),
      ),
    );
    for (int i = 0; i < lectures.length; i++) {
      widgets.add(LecturesCard(
        title: lectures[i]['title']!,
        tags: const [],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => LectureDetailPage(title: lectures[i]['title']!),
            ),
          );
        },
      ));
    }
    groupIndex++;
    if (groupIndex < groupCount) {
      widgets.add(const SizedBox(height: 24)); // More space between groups
    }
  });
  return widgets;
}
