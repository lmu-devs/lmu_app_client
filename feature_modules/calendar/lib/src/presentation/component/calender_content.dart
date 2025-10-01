import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/calendar_view_type.dart';
import '../component/calendar_entries_day_view.dart';
import '../component/calendar_entries_list_view.dart';
import 'loading_components/calendar_card_loading.dart';

class CalendarContent extends StatelessWidget {
  const CalendarContent({
    super.key,
    required this.entries,
    required this.viewType,
    this.isLoading = false,
    this.hasError = false,
    required this.selectedDateTimeRange,
    required this.scrollToDateRequest,
  });

  final List<CalendarEntry>? entries;
  final CalendarViewType viewType;
  final bool isLoading;
  final bool hasError;
  final DateTimeRange selectedDateTimeRange;
  final int scrollToDateRequest;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Column(
        children: [
          CalendarCardLoading(),
          CalendarCardLoading(),
          CalendarCardLoading(),
        ],
      );
      // TODO: Add error handling state and placeholder image
    }
    if (hasError) {
      return const Center(child: Text('Error loading events. Please try again.'));
    }

    if (entries == null || entries?.isEmpty == true) {
      // TODO: return an empty state with a placeholder image
      return const Center(child: Text('No events found.'));
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: viewType == CalendarViewType.day
          ? CalendarEntriesDayView(
              key: const ValueKey('dayView'),
              entries: entries ?? [],
              isToday: selectedDateTimeRange.start.isToday,
            )
          : CalendarEntriesListView(
              key: const ValueKey('listView'),
              entries: entries ?? [],
              selectedDate: selectedDateTimeRange.start,
              scrollToDateRequest: scrollToDateRequest,
            ),
    );
  }
}
