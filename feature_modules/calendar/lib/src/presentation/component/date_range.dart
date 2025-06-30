import 'package:flutter/material.dart';

import '../../domain/model/helper/date_time_formatter.dart';

class DateRangeDisplay extends StatelessWidget {
  const DateRangeDisplay({
    super.key,
    required this.start,
    required this.end,
    required this.allDay,
  });

  final DateTime start;
  final DateTime end;
  final bool allDay;

  bool get isSameDay => start.year == end.year && start.month == end.month && start.day == end.day;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (isSameDay) {
      final prefix = DateTimeFormatter.getRelativeDayLabel(start, context);
      final dateText = DateTimeFormatter.formatFullDate(start, context);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$prefix$dateText', style: textTheme.bodyMedium),
          if (allDay)
            Text('(ganztags)', style: textTheme.bodySmall)
          else
            Text('${DateTimeFormatter.formatTime(start, context)} - ${DateTimeFormatter.formatTime(end, context)}',
                style: textTheme.bodySmall),
        ],
      );
    } else {
      final startPrefix = allDay ? '' : DateTimeFormatter.formatTime(start, context);
      final endPrefix = allDay ? '' : DateTimeFormatter.formatTime(end, context);

      final startDate = DateTimeFormatter.formatShortDate(start, context);
      final endDate = DateTimeFormatter.formatShortDate(end, context);

      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(startDate, style: textTheme.bodyMedium),
              if (!allDay) Text(startPrefix, style: textTheme.bodySmall),
            ],
          ),
          const Icon(Icons.arrow_forward, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(endDate, style: textTheme.bodyMedium),
              if (!allDay) Text(endPrefix, style: textTheme.bodySmall),
            ],
          ),
        ],
      );
    }
  }
}
