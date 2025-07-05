import 'package:core/components.dart';
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
      final prefix = DateTimeFormatter.formatShortDate(start);
      final dateLmuText = DateTimeFormatter.formatFullDate(start, context);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuText('$prefix$dateLmuText', textStyle: textTheme.bodyMedium),
          if (allDay)
            LmuText('(ganztags)', textStyle: textTheme.bodySmall) // TODO: use localization
          else
            LmuText('${DateTimeFormatter.formatTime24h(start)} - ${DateTimeFormatter.formatTime24h(end)}',
                textStyle: textTheme.bodySmall),
        ],
      );
    } else {
      final startPrefix = allDay ? '' : DateTimeFormatter.formatTime24h(start);
      final endPrefix = allDay ? '' : DateTimeFormatter.formatTime24h(end);

      final startDate = DateTimeFormatter.formatShortDate(start);
      final endDate = DateTimeFormatter.formatShortDate(end);

      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuText(
                startDate,
              ),
              if (!allDay) LmuText(startPrefix, textStyle: textTheme.bodySmall),
            ],
          ),
          const Icon(Icons.arrow_forward, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuText(endDate, textStyle: textTheme.bodyMedium),
              if (!allDay) LmuText(endPrefix, textStyle: textTheme.bodySmall),
            ],
          ),
        ],
      );
    }
  }
}
