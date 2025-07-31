import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../bloc/lecture_list_cubit/lecture_list_cubit.dart';
import '../../domain/model/lecture.dart';
import '../component/lectures_card.dart';
import '../viewmodel/lecture_list_page_driver.dart';

class LectureListPage extends DrivableWidget<LectureListPageDriver> {
  LectureListPage({
    super.key,
    required this.facultyId,
    required this.facultyName,
  });

  final String facultyId;
  final String facultyName;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context, driver);
  }

  @override
  WidgetDriverProvider<LectureListPageDriver> get driverProvider =>
      _LectureListPageDriverProvider(facultyId, facultyName);

  Widget _buildContent(BuildContext context, LectureListPageDriver driver) {
    if (driver.isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(largeTitle: 'Loading...'),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (driver.hasError) {
      return LmuScaffold(
        appBar: LmuAppBarData(largeTitle: 'Error'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading lectures'),
              ElevatedButton(
                onPressed: driver.retry,
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final title = facultyName.isNotEmpty ? facultyName : 'Faculty Lectures';

    return Padding(
      padding: const EdgeInsets.only(top: LmuSizes.size_16),
      child: LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: title,
          leadingAction: LeadingAction.back,
          trailingWidgets: [
            // Faculty favorite icon in top right corner
            GestureDetector(
              onTap: driver.onFacultyFavoriteToggle,
              child: Padding(
                padding: const EdgeInsets.all(LmuSizes.size_4),
                child: StarIcon(
                  isActive: driver.isFacultyFavorite,
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
                    onPressed: driver.onFavoritesFilterToggle,
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  // Semester dropdown button
                  LmuButton(
                    title: driver.selectedSemester,
                    emphasis: ButtonEmphasis.secondary,
                    trailingIcon: Icons.keyboard_arrow_down,
                    onTap: () => _showSemesterDropdown(context),
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  // My Study button
                  LmuButton(
                    title: 'My Study', // TODO: use context.locals.lectures.myStudy
                    emphasis: ButtonEmphasis.secondary,
                    onTap: driver.onMyStudyPressed,
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
                      '${driver.lectureCount} Kurse', // TODO: use context.locals.lectures.coursesCount
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // Sort button aligned to the right
                    LmuIconButton(
                      icon: LucideIcons.arrow_up_down,
                      onPressed: driver.onSortPressed,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LmuSizes.size_32),
              // Alphabetic grouping and sorting of lectures
              ..._buildGroupedLectureCards(context, driver),
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

List<Widget> _buildGroupedLectureCards(BuildContext context, LectureListPageDriver driver) {
  // Get lectures from driver
  final lectures = driver.groupedLectures;

  if (lectures.isEmpty) {
    return [
      Center(
        child: Text('No lectures found'),
      ),
    ];
  }

  // Group by first letter
  Map<String, List<Lecture>> grouped = {};
  for (var lecture in lectures) {
    final letter = lecture.title[0].toUpperCase();
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
        id: lecture.id,
        title: lecture.title,
        tags: lecture.tags,
        isFavorite: lecture.isFavorite,
        onTap: () {
          // TODO: Navigate to lecture details
          driver.onLectureCardPressed(context, lecture.id, lecture.title);
        },
        onFavoriteTap: () {
          // TODO: Toggle favorite state
          driver.onLectureFavoriteToggle(lecture.id, lecture.isFavorite);
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

class _LectureListPageDriverProvider extends WidgetDriverProvider<LectureListPageDriver> {
  _LectureListPageDriverProvider(this.facultyId, this.facultyName);

  final String facultyId;
  final String facultyName;

  @override
  LectureListPageDriver buildDriver() {
    final cubit = LectureListCubit(facultyId: facultyId);
    return LectureListPageDriver(
      facultyId: facultyId,
      facultyName: facultyName,
      cubit: cubit,
    );
  }

  @override
  LectureListPageDriver buildTestDriver() {
    final cubit = LectureListCubit(facultyId: 'test');
    return LectureListPageDriver(
      facultyId: 'test',
      facultyName: 'test',
      cubit: cubit,
    );
  }
}
