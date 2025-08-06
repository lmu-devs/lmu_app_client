import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_lectures_usecase.dart';
import '../component/lecture_card.dart';
import '../viewmodel/lecture_list_page_driver.dart';

class LectureListPage extends DrivableWidget<LectureListPageDriver> {
  LectureListPage({
    super.key,
    required this.facultyId,
  });

  final int facultyId;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.facultyName,
        leadingAction: LeadingAction.back,
      ),
      body: _buildBody(context),
    );
  }

  @override
  WidgetDriverProvider<LectureListPageDriver> get driverProvider => _LectureListPageDriverProvider(facultyId);

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: LmuPageAnimationWrapper(
        child: Align(
          alignment: Alignment.topCenter,
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (driver.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (driver.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.locals.lectures.errorLoadingLectures),
            ElevatedButton(
              onPressed: driver.retry,
              child: Text(context.locals.lectures.retry),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        _buildHeaderRow(context),
        const SizedBox(height: LmuSizes.size_32),
        _buildLectureCountRow(context),
        const SizedBox(height: LmuSizes.size_32),
        ..._buildGroupedLectureCards(context, driver),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
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
        GestureDetector(
          onTap: driver.onFavoritesFilterToggle,
          child: Container(
            padding: const EdgeInsets.all(LmuSizes.size_8),
            decoration: BoxDecoration(
              color: driver.isFavoritesFilterActive
                  ? context.colors.neutralColors.backgroundColors.strongColors.base
                  : context.colors.neutralColors.backgroundColors.mediumColors.base,
              borderRadius: BorderRadius.circular(LmuSizes.size_8),
            ),
            child: StarIcon(
              isActive: driver.isFavoritesFilterActive,
              size: LmuIconSizes.mediumSmall,
            ),
          ),
        ),
        const SizedBox(width: LmuSizes.size_8),
        // Semester dropdown button
        LmuButton(
          title: 'Winter 24/25',
          emphasis: ButtonEmphasis.secondary,
          trailingIcon: Icons.keyboard_arrow_down,
          onTap: () => _showSemesterDropdown(context),
        ),
        const SizedBox(width: LmuSizes.size_8),
        // My Study button
        LmuButton(
          title: context.locals.lectures.myStudy,
          emphasis: ButtonEmphasis.secondary,
          onTap: driver.onMyStudyPressed,
        ),
      ],
    );
  }

  Widget _buildLectureCountRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          LmuText.body(
            '${driver.lectureCount} ${context.locals.lectures.coursesCount}',
          ),
          // Sort button aligned to the right
          LmuIconButton(
            icon: LucideIcons.arrow_up_down,
            onPressed: driver.onSortPressed,
          ),
        ],
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
            LmuText.h3(context.locals.lectures.selectSemester),
            const SizedBox(height: LmuSizes.size_16),
            // Current semester
            LmuButton(
              title: context.locals.lectures.winterSemester + ' 24/25',
              emphasis: ButtonEmphasis.primary,
              onTap: () {
                Navigator.pop(context);
                // TODO: implement semester selection
              },
            ),
            const SizedBox(height: LmuSizes.size_8),
            // Previous semesters
            LmuButton(
              title: context.locals.lectures.summerSemester + ' 24',
              emphasis: ButtonEmphasis.secondary,
              onTap: () {
                Navigator.pop(context);
                // TODO: implement semester selection
              },
            ),
            const SizedBox(height: LmuSizes.size_8),
            LmuButton(
              title: context.locals.lectures.winterSemester + ' 23/24',
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
  final lectures = driver.filteredLectures;

  if (lectures.isEmpty) {
    return [
      _buildEmptyState(context),
    ];
  }

  // Use driver's grouped lectures
  final groupedLectures = driver.groupedLectures;
  final List<Widget> widgets = [];

  for (final entry in groupedLectures.entries) {
    final letter = entry.key;
    final lecturesInGroup = entry.value;

    widgets.add(
      LmuTileHeadline.base(title: letter),
    );
    widgets.add(
      const SizedBox(height: LmuSizes.size_2),
    );

    widgets.add(
      ValueListenableBuilder<Set<String>>(
        valueListenable: GetIt.I<FavoriteLecturesUsecase>().favoriteIdsNotifier,
        builder: (context, favoriteIds, _) {
          return Column(
            children: lecturesInGroup.asMap().entries.map((entry) {
              final index = entry.key;
              final lecture = entry.value;
              final isFavorite = favoriteIds.contains(lecture.id);

              return Column(
                children: [
                  LectureCard(
                    id: lecture.id,
                    title: lecture.title,
                    tags: lecture.tags,
                    isFavorite: isFavorite,
                    onTap: () {
                      driver.onLectureCardPressed(context, lecture.id, lecture.title);
                    },
                    onFavoriteTap: () {
                      driver.onLectureFavoriteToggle(lecture.id);
                    },
                  ),
                  if (index < lecturesInGroup.length - 1) const SizedBox(height: LmuSizes.size_8),
                ],
              );
            }).toList(),
          );
        },
      ),
    );

    widgets.add(
      const SizedBox(height: LmuSizes.size_32),
    );
  }

  return widgets;
}

Widget _buildEmptyState(BuildContext context) {
  final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;

  return PlaceholderTile(
    minHeight: 56,
    content: [
      LmuText.bodySmall(context.locals.lectures.noLecturesFound, color: placeholderTextColor),
    ],
  );
}

class _LectureListPageDriverProvider extends WidgetDriverProvider<LectureListPageDriver> {
  _LectureListPageDriverProvider(this.facultyId);

  final int facultyId;

  @override
  LectureListPageDriver buildDriver() {
    return LectureListPageDriver(
      facultyId: facultyId,
    );
  }

  @override
  LectureListPageDriver buildTestDriver() {
    return LectureListPageDriver(
      facultyId: 1,
    );
  }
}
