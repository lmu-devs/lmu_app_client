import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_lucide/flutter_lucide.dart';

import '../component/course_list_item.dart';

import '../viewmodel/courses_overview_driver.dart';
import '../../application/usecase/favorite_courses_usecase.dart';

class CoursesOverview extends DrivableWidget<CoursesOverviewDriver> {
  CoursesOverview({super.key, required this.facultyId});

  final int facultyId;

  @override
  CoursesOverviewDriver createDriver() => GetIt.I<CoursesOverviewDriver>(param1: facultyId);

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.pageTitle,
        leadingAction: LeadingAction.back,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LmuPageAnimationWrapper(
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: _buildHeaderContent(context),
              ),
              _buildSearchAndFilterSection(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: _buildMainContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LmuText(driver.largeTitle, color: context.colors.neutralColors.textColors.mediumColors.base),
        const SizedBox(height: LmuSizes.size_32),
        _buildFavoritesSection(context),
        const SizedBox(height: LmuSizes.size_32),
      ],
    );
  }

  Widget _buildSearchAndFilterSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadline.base(title: "TBD"),
        ),
        LmuButtonRow(
          buttons: [
            LmuIconButton(
              icon: LucideIcons.search,
              onPressed: () => driver.onSearchPressed(context),
            ),
            LmuButton(
              title: "TBD",
              emphasis: driver.isProfessorFilterActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
              action: driver.isProfessorFilterActive ? ButtonAction.contrast : ButtonAction.base,
              onTap: driver.toggleProfessorFilter,
            ),
          ],
        ),
        const SizedBox(height: LmuSizes.size_16),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildGroupedCourses(context),
        const SizedBox(height: LmuSizes.size_32),
        _buildShowAllFacultiesButton(context),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  Widget _buildFavoritesSection(BuildContext context) {
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    final favoritesUsecase = GetIt.I<FavoriteCoursesUsecase>();

    return ValueListenableBuilder<Set<int>>(
      valueListenable: favoritesUsecase.favoriteIdsNotifier,
      builder: (context, favoriteIds, _) {
        final favoriteCourses = driver.courses.where((p) => favoriteIds.contains(p.publishId)).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: LmuSizes.size_24,
              child: StarIcon(isActive: false, size: LmuIconSizes.small, disabledColor: starColor),
            ),
            const SizedBox(height: LmuSizes.size_12),
            if (favoriteCourses.isNotEmpty)
              LmuContentTile(
                contentList: favoriteCourses
                    .map((course) => CourseListItem(
                          course: course,
                          onTap: () => driver.onPersonPressed(context, course),
                        ))
                    .toList(),
              )
            else
              _buildEmptyFavoritesState(context),
          ],
        );
      },
    );
  }

  Widget _buildEmptyFavoritesState(BuildContext context) {
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;

    return PlaceholderTile(
      minHeight: 56,
      content: [
        LmuText.bodySmall("TBD", color: placeholderTextColor),
        StarIcon(isActive: false, disabledColor: starColor, size: LmuIconSizes.small),
        LmuText.bodySmall("TBD", color: placeholderTextColor),
      ],
    );
  }

  List<Widget> _buildGroupedCourses(BuildContext context) {
    final groupedCourses = driver.groupedCourses;
    final List<Widget> widgets = [];

    for (final entry in groupedCourses.entries) {
      final letter = entry.key;
      final coursesInGroup = entry.value;

      widgets.add(
        LmuTileHeadline.base(title: letter),
      );

      widgets.add(
        LmuContentTile(
          contentList: coursesInGroup
              .map((course) => CourseListItem(
                    course: course,
                    onTap: () => driver.onPersonPressed(context, course),
                  ))
              .toList(),
        ),
      );

      widgets.add(
        const SizedBox(height: LmuSizes.size_32),
      );
    }

    return widgets;
  }

  Widget _buildShowAllFacultiesButton(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        title: driver.showAllFacultiesText,
        actionType: LmuListItemAction.chevron,
        onTap: () => driver.onShowAllFacultiesPressed(context),
      ),
    );
  }

  @override
  WidgetDriverProvider<CoursesOverviewDriver> get driverProvider => $CoursesOverviewDriverProvider(facultyId: facultyId);
}
