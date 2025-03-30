import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../repository/api/models/models.dart';

class TimelineContentView extends StatelessWidget {
  const TimelineContentView({super.key, required this.data});

  final TimelineData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final grouped = groupEventsBySemesterAndMonth(context, data);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: LmuSizes.size_8)),
        MultiSliver(
          children: grouped.entries.map((semesterEntry) {
            final semesterLabel = semesterEntry.key;
            final monthMap = semesterEntry.value;

            return SliverStickyHeader(
              header: Container(
                color: colors.neutralColors.backgroundColors.base,
                padding: const EdgeInsets.only(left: LmuSizes.size_16, right: LmuSizes.size_16, top: LmuSizes.size_8),
                child: LmuText.h3(semesterLabel),
              ),
              sliver: MultiSliver(
                children: monthMap.entries.map((monthEntry) {
                  final monthLabel = monthEntry.key;
                  final events = monthEntry.value;

                  events.sort((a, b) => a.timeframe.start.compareTo(b.timeframe.start));

                  return SliverStickyHeader.builder(
                    builder: (context, state) => Container(
                      padding: const EdgeInsets.only(
                          left: LmuSizes.size_16, right: LmuSizes.size_16, bottom: LmuSizes.size_8),
                      decoration: BoxDecoration(
                        color: colors.neutralColors.backgroundColors.base,
                        border: state.isPinned
                            ? Border(
                                bottom: BorderSide(
                                  color: colors.neutralColors.borderColors.seperatorLight,
                                  width: 1 - state.scrollPercentage,
                                ),
                              )
                            : null,
                      ),
                      child: LmuText.body(
                        monthLabel,
                        weight: FontWeight.w600,
                        color: colors.neutralColors.textColors.mediumColors.base,
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: LmuSizes.size_16,
                              right: LmuSizes.size_16,
                              bottom: LmuSizes.size_32,
                            ),
                            child: LmuContentTile(
                              contentList: events.map((event) {
                                return LmuListItem.base(
                                  leadingArea: LmuText.body(
                                    "${event.timeframe.start.day.toString().padLeft(2, '0')}.",
                                    weight: FontWeight.w600,
                                  ),
                                  title: event.title,
                                );
                              }).toList(),
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: LmuSizes.size_96)),
      ],
    );
  }
}

Map<String, Map<String, List<TimelineEvent>>> groupEventsBySemesterAndMonth(
  BuildContext context,
  TimelineData data,
) {
  final timelineLocals = context.locals.timeline;
  final result = <String, Map<String, List<TimelineEvent>>>{};

  for (final semester in data.semesters) {
    final semesterLabel = semester.formatSemesterLabel(timelineLocals);
    result.putIfAbsent(semesterLabel, () => {});
  }

  for (final event in data.events) {
    final eventStart = event.timeframe.start;

    final semester = data.semesters.firstWhere(
      (s) => eventStart.isAfter(s.timeframe.start) && eventStart.isBefore(s.timeframe.end),
      orElse: () => throw Exception("No matching semester found for event"),
    );

    final semesterLabel = semester.formatSemesterLabel(timelineLocals);
    final monthLabel = eventStart.localizedMonth(timelineLocals);

    result[semesterLabel]!.putIfAbsent(monthLabel, () => []);
    result[semesterLabel]![monthLabel]!.add(event);
  }

  return result;
}

extension on TimelineSemester {
  String formatSemesterLabel(TimelineLocatizations locals) {
    final year = timeframe.start.year;
    final nextYear = timeframe.start.month >= 10 ? year + 1 : year;
    final semesterStr = type == SemesterType.winter ? "${locals.winter} $year/$nextYear" : "${locals.summer} $nextYear";
    return semesterStr;
  }
}

extension on DateTime {
  String localizedMonth(TimelineLocatizations locals) {
    final monthNames = [
      locals.january,
      locals.february,
      locals.march,
      locals.april,
      locals.may,
      locals.june,
      locals.july,
      locals.august,
      locals.september,
      locals.october,
      locals.november,
      locals.december
    ];
    return monthNames[month - 1];
  }
}
