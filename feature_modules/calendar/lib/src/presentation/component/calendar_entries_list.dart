import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/helper/date_time_formatter.dart';
import 'calendar_entry_card_dynamic.dart';

typedef OnEventTapCallback = void Function(CalendarEntry event, BuildContext context);

class CalendarEntriesListView extends StatelessWidget {
  const CalendarEntriesListView({
    super.key,
    required this.entries,
  });

  final List<CalendarEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(
        child: Text('No entries found.'),
      );
    }

    final List<Widget> listItems = _buildItemList(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_8),
      children: listItems,
    );
  }

  List<Widget> _buildItemList(BuildContext context) {
    final List<Widget> items = [];
    DateTime? lastDate;

    final sortedEntries = List<CalendarEntry>.from(entries)..sort((a, b) => a.startTime.compareTo(b.startTime));

    for (int i = 0; i < sortedEntries.length; i++) {
      final event = sortedEntries[i];
      final currentDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);

      if (lastDate == null || !currentDate.isAtSameMomentAs(lastDate)) {
        if (lastDate != null) {
          final daysBetween = currentDate.difference(lastDate).inDays;
          if (daysBetween > 1) {
            items.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_8),
                child: Text(
                  '$daysBetween days without entries',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }

        items.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_24),
            child: LmuText(
              DateTimeFormatter.formatFullDate(currentDate, context),
              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: currentDate.isSameDay(DateTime.now()) ? Theme.of(context).colorScheme.primary : null),
            ),
          ),
        );
        lastDate = currentDate;
      }

      items.add(
        Padding(
          padding: const EdgeInsets.only(bottom: LmuSizes.size_2),
          child: CalendarCard(
            key: Key("calendar_event_${event.id}"),
            entry: event,
          ),
        ),
      );
    }

    return items;
  }
}
