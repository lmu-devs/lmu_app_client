import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/sports_course.dart';
import '../repository/api/models/sports_type.dart';
import '../routes/sports_routes.dart';
import '../services/sports_state_service.dart';

class SportsGroupedCourseSection extends StatelessWidget {
  const SportsGroupedCourseSection({super.key, required this.sportsTypes});

  final List<SportsType> sportsTypes;

  @override
  Widget build(BuildContext context) {
    final sportsStateService = GetIt.I.get<SportsStateService>();
    final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    final locals = context.locals;
    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_16),
        ValueListenableBuilder(
          valueListenable: sportsStateService.isSearchActiveNotifier,
          builder: (context, isSearchActive, child) {
            if (isSearchActive) return const SizedBox.shrink();
            return child!;
          },
          child: ValueListenableBuilder(
            valueListenable: sportsStateService.favoriteSportsCoursesNotifier,
            builder: (context, favoriteSports, _) {
              final favoriteSportTitles = favoriteSports.map((sport) => sport.category).toList();
              final favoriteSportTypes = sportsTypes.where((sport) => favoriteSportTitles.contains(sport.title));

              return Padding(
                padding: const EdgeInsets.all(LmuSizes.size_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: LmuSizes.size_24,
                      child: StarIcon(isActive: false, size: LmuIconSizes.small, disabledColor: starColor),
                    ),
                    const SizedBox(height: LmuSizes.size_12),
                    if (favoriteSports.isNotEmpty)
                      LmuContentTile(
                        content: favoriteSportTypes.map(
                          (sport) {
                            return LmuListItem.action(
                              title: sport.title,
                              leadingArea: LmuStatusDot(statusColor: sport.courses.statusColor),
                              actionType: LmuListItemAction.chevron,
                              trailingTitle: '${sport.courses.length}',
                              mainContentAlignment: MainContentAlignment.center,
                              onTap: () => SportsDetailsRoute(sport).go(context),
                            );
                          },
                        ).toList(),
                      ),
                    if (favoriteSports.isEmpty)
                      PlaceholderTile(
                        minHeight: 56,
                        content: [
                          LmuText.bodySmall(locals.canteen.emptyFavoritesBefore, color: placeholderTextColor),
                          StarIcon(isActive: false, disabledColor: starColor, size: LmuSizes.size_16),
                          LmuText.bodySmall(locals.canteen.emptyFavoritesAfter, color: placeholderTextColor),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: sportsStateService.filteredGroupedSportsNotifier,
          builder: (context, filteredGroupedSports, _) {
            if (filteredGroupedSports.isEmpty) return LmuIssueType(message: locals.app.searchEmpty, hasSpacing: false);
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredGroupedSports.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final groupEntries = filteredGroupedSports.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
                final groupEntry = groupEntries[index];
                final groupKey = groupEntry.key;
                final sportsInGroup = groupEntry.value;

                return Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LmuTileHeadline.base(title: groupKey),
                      LmuContentTile(
                        content: sportsInGroup.map(
                          (sport) {
                            final courseCount = sport.courses.length;

                            return LmuListItem.action(
                              title: sport.title,
                              leadingArea: LmuStatusDot(statusColor: sport.courses.statusColor),
                              actionType: LmuListItemAction.chevron,
                              trailingTitle: '$courseCount',
                              mainContentAlignment: MainContentAlignment.center,
                              onTap: () => SportsDetailsRoute(sport).go(context),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

extension on List<SportsCourse> {
  StatusColor get statusColor {
    int availableCount = where((course) => course.isAvailable).length;
    double availabilityRatio = availableCount / length;

    if (availabilityRatio == 0) {
      return StatusColor.red;
    } else if (availabilityRatio < 0.5) {
      return StatusColor.yellow;
    } else {
      return StatusColor.green;
    }
  }
}
