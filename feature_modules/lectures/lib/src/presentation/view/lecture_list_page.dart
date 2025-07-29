import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../component/lectures_card.dart';

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
    final lectures = _lectures;
    final isFacultyFavorite = false; // TODO: implement faculty favorite state
    final showOnlyFavorites = false; // TODO: implement favorites filter state

    return Padding(
      padding: const EdgeInsets.only(top: LmuSizes.size_16),
      child: LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: facultyName,
          leadingAction: LeadingAction.back,
          trailingWidgets: [
            // Faculty favorite icon in top right corner
            GestureDetector(
              onTap: () {
                // TODO: handle faculty favorite toggle
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFacultyFavorite ? 'Faculty removed from favorites' : 'Faculty added to favorites'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(LmuSizes.size_4),
                child: StarIcon(
                  isActive: isFacultyFavorite,
                  disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: search, favorites filter, dropdown, my study
              Row(
                children: [
                  // Search button
                  LmuIconButton(
                    icon: LucideIcons.search,
                    onPressed: () {
                      // TODO: implement search functionality
                    },
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  // Favorites filter button
                  LmuIconButton(
                    icon: LucideIcons.star,
                    onPressed: () {
                      // TODO: implement favorites filter toggle
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(showOnlyFavorites ? 'Showing all courses' : 'Showing only favorites'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  // Semester dropdown button
                  LmuButton(
                    title: 'Winter 24/25', // TODO: use context.locals.lectures.winterSemester
                    emphasis: ButtonEmphasis.secondary,
                    trailingIcon: Icons.keyboard_arrow_down,
                    onTap: () {
                      // TODO: handle semester change
                      _showSemesterDropdown(context);
                    },
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  // My Study button
                  LmuButton(
                    title: 'My Study', // TODO: use context.locals.lectures.myStudy
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
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${lectures.length} Kurse', // TODO: use context.locals.lectures.coursesCount
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

  void _showSemesterDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LmuText.h3('Select Semester'),
            const SizedBox(height: LmuSizes.size_16),
            // Current semester
            LmuButton(
              title: 'Winter 24/25', // TODO: use context.locals.lectures.winterSemester
              emphasis: ButtonEmphasis.primary,
              onTap: () {
                Navigator.pop(context);
                // TODO: implement semester selection
              },
            ),
            const SizedBox(height: LmuSizes.size_8),
            // Previous semesters
            LmuButton(
              title: 'Summer 24', // TODO: use context.locals.lectures.summerSemester
              emphasis: ButtonEmphasis.secondary,
              onTap: () {
                Navigator.pop(context);
                // TODO: implement semester selection
              },
            ),
            const SizedBox(height: LmuSizes.size_8),
            LmuButton(
              title: 'Winter 23/24', // TODO: use context.locals.lectures.winterSemester
              emphasis: ButtonEmphasis.secondary,
              onTap: () {
                Navigator.pop(context);
                // TODO: implement semester selection
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Hardcoded lecture data with proper structure
List<Map<String, dynamic>> _lectures = [
  {
    'id': '1',
    'title': 'Credit Risk Modelling',
    'tags': ['VL', '6 SWS', 'Master', 'English'],
    'isFavorite': false,
  },
  {
    'id': '2',
    'title': 'Cybersecurity',
    'tags': ['VL', '4 SWS', 'Bachelor', 'German'],
    'isFavorite': true,
  },
  {
    'id': '3',
    'title': 'Game Development',
    'tags': ['VL', '8 SWS', 'Bachelor', 'English'],
    'isFavorite': false,
  },
];

List<Widget> _buildGroupedLectureCards(BuildContext context) {
  // Sort lectures alphabetically by title
  final sortedLectures = List<Map<String, dynamic>>.from(_lectures)..sort((a, b) => a['title']!.compareTo(b['title']!));

  // Group by first letter
  Map<String, List<Map<String, dynamic>>> grouped = {};
  for (var lecture in sortedLectures) {
    final letter = lecture['title']![0].toUpperCase();
    grouped.putIfAbsent(letter, () => []).add(lecture);
  }

  // Build widgets
  List<Widget> widgets = [];
  final groupEntries = grouped.entries.toList();

  for (int groupIndex = 0; groupIndex < groupEntries.length; groupIndex++) {
    final entry = groupEntries[groupIndex];
    final letter = entry.key;
    final lectures = entry.value;

    // Add 32px spacing before each letter (except the first one)
    if (groupIndex > 0) {
      widgets.add(const SizedBox(height: LmuSizes.size_32));
    }

    // Add letter with built-in bottom padding (12px)
    widgets.add(
      LmuTileHeadline.base(title: letter),
    );

    // Add lecture cards
    for (int i = 0; i < lectures.length; i++) {
      final lecture = lectures[i];
      widgets.add(LecturesCard(
        id: lecture['id']!,
        title: lecture['title']!,
        tags: List<String>.from(lecture['tags']!),
        isFavorite: lecture['isFavorite']!,
        onTap: () {
          // TODO: Navigate to lecture details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${lecture['title']}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        onFavoriteTap: () {
          // TODO: Toggle favorite state
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${lecture['isFavorite'] ? 'Removed from' : 'Added to'} favorites'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ));

      // Add 8px spacing between lecture cards (except after the last one in a group)
      if (i < lectures.length - 1) {
        widgets.add(const SizedBox(height: LmuSizes.size_8));
      }
    }
  }

  return widgets;
}
