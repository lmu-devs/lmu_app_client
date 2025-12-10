import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/course_model.dart';
import '../component/course_card.dart';

import '../component/course_filter_bottom_sheet.dart';
import '../component/courses_empty_state.dart';
import '../viewmodel/courses_overview_driver.dart';
import '../../application/usecase/favorite_courses_usecase.dart';

class CoursesOverview extends DrivableWidget<CoursesOverviewDriver> {
  CoursesOverview({super.key, required this.facultyId});

  final int facultyId;

  CoursesOverviewDriver createDriver() =>
      GetIt.I<CoursesOverviewDriver>(param1: facultyId);

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
                padding:
                    const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LmuText(driver.largeTitle,
                        color: context
                            .colors.neutralColors.textColors.mediumColors.base),
                    const SizedBox(height: LmuSizes.size_32),
                    _buildFavoritesSection(context),
                    const SizedBox(height: LmuSizes.size_32),
                  ],
                ),
              ),
              _buildSearchAndFilterSection(context),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildGroupedCourses(context),
                    _buildShowAllFacultiesButton(context),
                    const SizedBox(height: LmuSizes.size_96),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesSection(BuildContext context) {
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    final favoritesUsecase = GetIt.I<FavoriteCoursesUsecase>();

    return ValueListenableBuilder<Map<int, List<int>>>(
      valueListenable: favoritesUsecase.favoritesMapNotifier,
      builder: (context, favoritesMap, _) {
        final List<int> favoriteIdsForFaculty = favoritesMap[facultyId] ?? [];

        final List<int> filteredFavoriteIds = [];
        final List<CourseModel> favoriteCourses = [];
        for (final id in favoriteIdsForFaculty) {
          try {
            final course =
                driver.courses.firstWhere((course) => course.publishId == id);
            favoriteCourses.add(course);

            if (course.publishId == id) {
              filteredFavoriteIds.add(id);
            }
          } catch (e) {}
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: LmuSizes.size_24,
              child: StarIcon(
                isActive: false,
                size: LmuIconSizes.small,
                disabledColor: starColor,
              ),
            ),
            const SizedBox(height: LmuSizes.size_6),
            driver.isLoading
                ? favoriteIdsForFaculty.isEmpty
                    ? _buildEmptyFavoritesState(context)
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: LmuSizes.size_6),
                          ...List.filled(
                            favoriteIdsForFaculty.length,
                            CourseCard.loading(),
                          ),
                        ],
                      )
                : LmuReorderableFavoriteList(
                    favoriteIds:
                        filteredFavoriteIds.map((id) => id.toString()).toList(),
                    placeholder: _buildEmptyFavoritesState(context),
                    onReorder: (oldIndex, newIndex) {
                      final newFilteredOrder = List.of(filteredFavoriteIds);
                      final item = newFilteredOrder.removeAt(oldIndex);
                      newFilteredOrder.insert(newIndex, item);

                      final List<int> finalOrder = [];
                      int visibleIndex = 0;

                      for (final id in favoriteIdsForFaculty) {
                        if (filteredFavoriteIds.contains(id)) {
                          finalOrder.add(newFilteredOrder[visibleIndex]);
                          visibleIndex++;
                        } else {
                          finalOrder.add(id);
                        }
                      }

                      driver.updateFavoriteCoursesOrder(finalOrder);
                    },
                    itemBuilder: (context, index) {
                      final course = favoriteCourses[index];
                      return Padding(
                        key: ValueKey(course.publishId),
                        padding: const EdgeInsets.symmetric(
                            vertical: LmuSizes.size_6),
                        child: CourseCard(
                          course: course,
                          hasDivider: false,
                          isFavorite: driver.isFavorite(course.publishId),
                          onTap: () => driver.onCoursePressed(context, course),
                          onFavoriteTap: () =>
                              driver.toggleFavorite(context, course.publishId),
                        ),
                      );
                    },
                  ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyFavoritesState(BuildContext context) {
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    final placeholderTextColor =
        context.colors.neutralColors.textColors.mediumColors.base;

    return Padding(
      padding: const EdgeInsets.only(top: LmuSizes.size_6),
      child: PlaceholderTile(
        minHeight: 56,
        content: [
          LmuText.bodySmall(
            context.locals.courses.favoritesBefore,
            color: placeholderTextColor,
          ),
          StarIcon(
            isActive: false,
            disabledColor: starColor,
            size: LmuIconSizes.small,
          ),
          LmuText.bodySmall(
            context.locals.courses.favoritesAfter,
            color: placeholderTextColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadline.base(
              title: "${driver.courses.length} ${driver.pageTitle}"),
        ),
        LmuButtonRow(
          buttons: [
            LmuIconButton(
              icon: LucideIcons.search,
              isDisabled: driver.isLoading,
              onPressed: () =>
                  driver.isLoading ? {} : driver.onSearchPressed(context),
            ),
            LmuButton(
              title: "Filter",
              emphasis: driver.isFilterActive
                  ? ButtonEmphasis.primary
                  : ButtonEmphasis.secondary,
              state:
                  driver.isLoading ? ButtonState.disabled : ButtonState.enabled,
              onTap: () =>
                  driver.isLoading ? {} : _showFilterBottomSheet(context),
            ),
          ],
        ),
        const SizedBox(height: LmuSizes.size_16),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    LmuBottomSheet.showExtended(
      context,
      content: CourseFilterBottomSheet(
        availableDegrees: driver.availableDegrees,
        availableTypes: driver.availableTypes,
        availableLanguages: driver.availableLanguages,
        availableSws: driver.availableSws,
        selectedDegrees: driver.selectedDegrees,
        selectedTypes: driver.selectedTypes,
        selectedLanguages: driver.selectedLanguages,
        selectedSws: driver.selectedSws,
        onApply: (degrees, types, languages, sws) {
          driver.applyFilters(
            degrees: degrees,
            types: types,
            languages: languages,
            sws: sws,
          );
        },
      ),
    );
  }

  List<Widget> _buildGroupedCourses(BuildContext context) {
    if (driver.isLoading) {
      return [
        LmuTileHeadline.base(title: "A"),
        ...List.filled(4, CourseCard.loading()),
        LmuTileHeadline.base(title: "B"),
        ...List.filled(4, CourseCard.loading()),
      ];
    }

    final groupedCourses = driver.groupedCourses;
    final List<Widget> widgets = [];

    if (groupedCourses.isEmpty && driver.isFilterActive) {
      return [
        const CoursesEmptyState(
            emptyStateType: CoursesEmptyStateType.noCoursesFound),
      ];
    }

    for (final entry in groupedCourses.entries) {
      final letter = entry.key;
      final coursesInGroup = entry.value;

      widgets.add(
        LmuTileHeadline.base(title: letter),
      );

      widgets.add(
        Column(
          children: coursesInGroup
              .map(
                (course) => CourseCard(
                  course: course,
                  isFavorite: driver.isFavorite(course.publishId),
                  onTap: () => driver.onCoursePressed(context, course),
                  onFavoriteTap: () =>
                      driver.toggleFavorite(context, course.publishId),
                ),
              )
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
  WidgetDriverProvider<CoursesOverviewDriver> get driverProvider =>
      $CoursesOverviewDriverProvider(facultyId: facultyId);
}
