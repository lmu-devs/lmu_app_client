import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/sports.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../extensions/sports_status_color_extension.dart';
import '../repository/api/models/sports_type.dart';
import '../services/sports_state_service.dart';

class SportsFavoritesCourseSection extends StatelessWidget {
  const SportsFavoritesCourseSection({super.key, required this.sportsTypes});

  final List<SportsType> sportsTypes;

  @override
  Widget build(BuildContext context) {
    final sportsStateService = GetIt.I.get<SportsStateService>();
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;
    final locals = context.locals;

    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_32),
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
                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
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
                        contentList: favoriteSportTypes.map(
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
        const SizedBox(height: LmuSizes.size_32)
      ],
    );
  }
}
