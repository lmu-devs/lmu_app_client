import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../extensions/sports_status_color_extension.dart';
import '../repository/api/models/sports_type.dart';
import '../routes/sports_routes.dart';
import '../services/sports_state_service.dart';

class SportsAllCourseSection extends StatelessWidget {
  const SportsAllCourseSection({super.key, required this.sportsTypes});

  final List<SportsType> sportsTypes;

  @override
  Widget build(BuildContext context) {
    final sportsStateService = GetIt.I.get<SportsStateService>();
    final locals = context.locals;
    return Column(
      children: [
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
                  padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LmuTileHeadline.base(title: groupKey),
                      LmuContentTile(
                        contentList: sportsInGroup.map(
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
                      if (index != filteredGroupedSports.length - 1) const SizedBox(height: LmuSizes.size_32),
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
