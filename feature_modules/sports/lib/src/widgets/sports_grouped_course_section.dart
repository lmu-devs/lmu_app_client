import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/sports_course.dart';
import '../routes/sports_routes.dart';
import '../services/sports_state_service.dart';

class SportsGroupedCourseSection extends StatelessWidget {
  const SportsGroupedCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sportsStateService = GetIt.I.get<SportsStateService>();

    return ValueListenableBuilder(
      valueListenable: sportsStateService.filteredGroupedSportsNotifier,
      builder: (context, filteredGroupedSports, _) {
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
                    content: [
                      for (final sport in sportsInGroup)
                        LmuListItem.action(
                          title: sport.title,
                          leadingArea: LmuStatusDot(statusColor: sport.courses.statusColor),
                          actionType: LmuListItemAction.chevron,
                          trailingTitle: '${sport.courses.length} ${sport.courses.length == 1 ? "Kurs" : "Kurse"}',
                          mainContentAlignment: MainContentAlignment.center,
                          onTap: () => SportsDetailsRoute(sport).go(context),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
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

  List<SportsCourse> get availableCourses => where((course) => course.isAvailable).toList();
}
