import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';

import '../extensions/date_time_extension.dart';
import '../repository/api/models/sports_course.dart';
import '../repository/api/models/sports_type.dart';
import '../widgets/sports_course_tile.dart';

class SportsDetailsPage extends StatelessWidget {
  const SportsDetailsPage({super.key, required this.sport});

  final SportsType sport;

  Map<({DateTime startDate, DateTime endDate}), List<SportsCourse>> get _groupedSports {
    final grouped = groupBy(sport.courses, (SportsCourse course) {
      return (startDate: DateTime.parse(course.startDate), endDate: DateTime.parse(course.endDate));
    });

    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.startDate.compareTo(a.key.startDate)),
    );
  }

  String _categoryTitle(SportsLocatizations locals, DateTime startDate, DateTime endDate) {
    final currentDate = DateTime.now();
    if (currentDate.isBefore(startDate)) {
      return locals.upcoming;
    } else if (currentDate.isAfter(endDate)) {
      return locals.past;
    } else {
      return locals.ongoing;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sportsLocals = context.locals.sports;
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: sport.title,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: LmuSizes.size_16),
              ..._groupedSports.entries.map(
                (entry) {
                  final startDate = entry.key.startDate;
                  final endDate = entry.key.endDate;
                  final courses = entry.value.sorted((a, b) => a.isAvailable ? -1 : 1);

                  final formattedStartDate = startDate.formattedDate;
                  final formattedEndDate = endDate.formattedDate;

                  final startIsEndDate = formattedStartDate == formattedEndDate;

                  return Column(
                    children: [
                      LmuTileHeadline.base(
                        title: _categoryTitle(sportsLocals, startDate, endDate),
                        trailingTitle: startIsEndDate
                            ? formattedStartDate
                            : "${startDate.formattedDate} - ${endDate.formattedDate}",
                      ),
                      ...courses
                          .mapIndexed(
                            (index, course) => SportsCourseTile(
                              course: course,
                              hasDivider: index != courses.length - 1,
                              sportType: sport.title,
                            ),
                          )
                          .toList(),
                      const SizedBox(height: LmuSizes.size_32),
                    ],
                  );
                },
              ),
              const SizedBox(height: LmuSizes.size_64),
            ],
          ),
        ),
      ),
    );
  }
}
