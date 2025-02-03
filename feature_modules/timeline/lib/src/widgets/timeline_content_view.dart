import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

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
        return event.timeframe.start.isAfter(semester.timeframe.start) &&
            event.timeframe.end.isBefore(semester.timeframe.end);
      }).toList();
    }

    final currentEvents = events.where((event) {
      return event.timeframe.start.isBefore(DateTime.now()) && event.timeframe.end.isAfter(DateTime.now());
    }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          for (final semester in semesters)
            LmuTileHeadline.base(
              title: semester.type,
              trailingTitle: semester.timeframe.start.toString().split(' ')[0] +
                  " - " +
                  semester.timeframe.end.toString().split(' ')[0],
            ),
          for (final event in events)
            LmuContentTile(
              content: [
                LmuListItem.base(
                  title: event.title,
                  mainContentAlignment: MainContentAlignment.top,
                  subtitle: "in ${event.timeframe.start.difference(DateTime.now()).inDays} Tagen",
                  trailingTitle: event.timeframe.start.toString().split(' ')[0],
                  trailingSubtitle: "bis ${event.timeframe.end.toString().split(' ')[0]}",
                ),
              ],
            ),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }
}
