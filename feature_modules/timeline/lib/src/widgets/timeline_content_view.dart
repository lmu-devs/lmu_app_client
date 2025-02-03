import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/api/models/timeline_data.dart';
import '../repository/api/models/timeline_event.dart';
import '../repository/api/models/timeline_semester.dart';

class TimelineContentView extends StatelessWidget {
  const TimelineContentView({super.key, required this.timelineData});

  final TimelineData timelineData;

  @override
  Widget build(BuildContext context) {
    final semesters = timelineData.semesters;
    final events = timelineData.events;
    final Map<TimelineSemester, List<TimelineEvent>> semesterEvents = {};

    for (final semester in semesters) {
      semesterEvents[semester] = events.where((event) {
        return event.timeframe.start.isBefore(semester.timeframe.end) &&
            event.timeframe.end.isAfter(semester.timeframe.start);
      }).toList();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ...semesterEvents.keys.mapIndexed(
            (index, semester) {
              final events = semesterEvents[semester] ?? [];
              final currentEvents = events.where((event) {
                return event.timeframe.start.isBefore(DateTime.now()) && event.timeframe.end.isAfter(DateTime.now());
              }).toList();
              final oldEvents = events.where((event) {
                return event.timeframe.end.isBefore(DateTime.now());
              }).toList();
              final upcomingEvents = events.where((event) {
                return event.timeframe.start.isAfter(DateTime.now());
              }).toList();

              return Column(
                children: [
                  SizedBox(height: index == 0 ? LmuSizes.size_16 : LmuSizes.size_32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                    child: LmuTileHeadline.base(
                      title: semester.type.localizedName(),
                      trailingTitle: DateFormat("dd.MM.yyyy").format(semester.timeframe.start),
                    ),
                  ),
                  if (oldEvents.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                      child: LmuContentTile(
                        content: oldEvents.mapIndexed(
                          (index, event) {
                            final eventStart = event.timeframe.start;
                            final eventEnd = event.timeframe.end;

                            final isInSameYear = eventStart.year == eventEnd.year;

                            final isInPreviousYear = eventStart.year < eventEnd.year;
                            final formattedStart = (isInSameYear && !isInPreviousYear)
                                ? DateFormat("dd.MM.").format(eventStart)
                                : DateFormat("dd.MM.yyyy").format(eventStart);

                            final formattedEnd = (isInSameYear && !isInPreviousYear)
                                ? DateFormat("dd.MM.").format(eventEnd)
                                : DateFormat("dd.MM.yyyy").format(eventEnd);

                            final timeSinceEnd = DateTime.now().difference(event.timeframe.end).inDays;
                            return LmuListItem.base(
                              title: event.title,
                              mainContentAlignment: MainContentAlignment.top,
                              subtitle: "vor $timeSinceEnd ${timeSinceEnd > 1 ? "Tagen" : "Tag"}",
                              trailingTitle: formattedStart,
                              trailingSubtitle: (formattedStart != formattedEnd) ? "bis $formattedEnd" : null,
                              hasDivider: index != oldEvents.length - 1,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  if (currentEvents.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                        left: 6.0,
                        right: 16.0,
                        top: (oldEvents.isNotEmpty) ? LmuSizes.size_8 : 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                width: LmuSizes.size_4,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: context.colors.brandColors.backgroundColors.strongColors.base,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 32,
                            child: LmuContentTile(
                              content: currentEvents.mapIndexed(
                                (index, event) {
                                  final eventStart = event.timeframe.start;
                                  final eventEnd = event.timeframe.end;

                                  final isInSameYear = eventStart.year == eventEnd.year;

                                  final formattedStart = isInSameYear
                                      ? DateFormat("dd.MM.").format(eventStart)
                                      : DateFormat("dd.MM.yyyy").format(eventStart);

                                  final formattedEnd = DateFormat("dd.MM.yyyy").format(eventEnd);
                                  final daysUntilEnd = eventEnd.difference(DateTime.now()).inDays;

                                  return LmuListItem.base(
                                    title: event.title,
                                    mainContentAlignment: MainContentAlignment.top,
                                    subtitle: "noch $daysUntilEnd Tage",
                                    trailingTitle: formattedStart,
                                    trailingSubtitle: (formattedStart != formattedEnd) ? "bis $formattedEnd" : null,
                                    hasDivider: index != currentEvents.length - 1,
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (upcomingEvents.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                        left: LmuSizes.size_16,
                        right: LmuSizes.size_16,
                        top: (oldEvents.isNotEmpty || currentEvents.isNotEmpty) ? LmuSizes.size_8 : 0,
                      ),
                      child: LmuContentTile(
                        content: upcomingEvents.mapIndexed(
                          (index, event) {
                            final eventStart = event.timeframe.start;
                            final eventEnd = event.timeframe.end;

                            final isInSameYear = eventStart.year == eventEnd.year;

                            final formattedStart = isInSameYear
                                ? DateFormat("dd.MM.").format(eventStart)
                                : DateFormat("dd.MM.yyyy").format(eventStart);

                            final formattedEnd = isInSameYear
                                ? DateFormat("dd.MM.").format(eventEnd)
                                : DateFormat("dd.MM.yyyy").format(eventEnd);
                            final timeUntilStart = eventStart.difference(DateTime.now()).inDays;
                            return LmuListItem.base(
                              title: event.title,
                              mainContentAlignment: MainContentAlignment.top,
                              subtitle: "in $timeUntilStart ${timeUntilStart > 1 ? "Tagen" : "Tag"}",
                              trailingTitle: formattedStart,
                              trailingSubtitle: (formattedStart != formattedEnd) ? "bis $formattedEnd" : null,
                              hasDivider: index != upcomingEvents.length - 1,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }
}

extension on SemesterType {
  String localizedName() {
    return switch (this) {
      SemesterType.summer => "Sommersemester",
      SemesterType.winter => "Wintersemester",
    };
  }
}
