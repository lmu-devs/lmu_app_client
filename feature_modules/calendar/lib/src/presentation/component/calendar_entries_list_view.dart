import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import 'calendar_date_info_label.dart';
import 'calendar_entry_card_dynamic.dart';

class CalendarEntriesListView extends StatefulWidget {
  const CalendarEntriesListView({
    super.key,
    required this.entries,
    this.selectedDate,
  });

  final List<CalendarEntry> entries;
  final DateTime? selectedDate;

  @override
  State<CalendarEntriesListView> createState() => _CalendarEntriesListViewState();
}

class _CalendarEntriesListViewState extends State<CalendarEntriesListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _scrollToSelectedDate() {
    if (widget.selectedDate == null || widget.entries.isEmpty) return;

    final sortedEntries = List<CalendarEntry>.from(widget.entries)..sort((a, b) => a.startTime.compareTo(b.startTime));

    final index = sortedEntries.indexWhere((entry) {
      return entry.startTime.isSameDay(widget.selectedDate!);
    });

    if (index != -1) {
      _scrollController.jumpTo(
        index * 120.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entries.isEmpty) {
      return const Center(child: Text('No entries found.'));
    }

    final listItems = _buildItemList(context);

    return ListView(
      controller: _scrollController,
      children: listItems,
    );
  }

  List<Widget> _buildItemList(BuildContext context) {
    final List<Widget> items = [];
    DateTime? lastDate;

    final sortedEntries = List<CalendarEntry>.from(widget.entries)..sort((a, b) => a.startTime.compareTo(b.startTime));

    final now = DateTime.now();

    for (int i = 0; i < sortedEntries.length; i++) {
      final event = sortedEntries[i];
      final currentDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);

      final isNewDay = lastDate == null || !currentDate.isAtSameMomentAs(lastDate);

      if (isNewDay) {
        if (lastDate != null) {
          final daysBetween = currentDate.difference(lastDate).inDays;

          if (daysBetween > 1) {
            // Always show empty range for any gap > 1 day between entries
            items.add(
              CalendarDateInfoLabel.emptyRange(
                lastDate: lastDate,
                currentDate: currentDate,
              ),
            );
          }

          final isNextYear = currentDate.year != (lastDate.year);

          if (isNextYear) {
            items.add(
              CalendarDateInfoLabel.year(
                date: currentDate,
              ),
            );
          }

          // If month changes, show month label
          if (currentDate.month != lastDate.month) {
            items.add(
              CalendarDateInfoLabel.month(
                date: currentDate,
              ),
            );
          }
        } else {
          // First entry also needs a month label
          items.add(
            CalendarDateInfoLabel.month(
              date: currentDate,
            ),
          );
        }

        // Always show day label for the first entry of that day
        final diff = currentDate.difference(DateTime(now.year, now.month, now.day)).inDays;
        items.add(
          CalendarDateInfoLabel.day(
            date: currentDate,
            isToday: diff == 0,
          ),
        );

        lastDate = currentDate;
      }

      // Add the entry card
      items.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(LmuSizes.size_8, 0, LmuSizes.size_8, LmuSizes.size_2),
          child: CalendarCard(
            key: Key("calendar_event_${event.id}"),
            entry: event,
          ),
        ),
      );

      // End marker
      if (i == sortedEntries.length - 1) {
        items.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_32),
            child: LmuText.bodySmall(
              'No more entries',
              textAlign: TextAlign.center,
              color: context.colors.neutralColors.textColors.weakColors.base,
            ),
          ),
        );
      }
    }

    return items;
  }
}
