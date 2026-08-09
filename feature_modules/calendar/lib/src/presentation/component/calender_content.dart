import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/calendar_view_type.dart';
import '../component/calendar_entries_day_view.dart';
import '../component/calendar_entries_list_view.dart';
import 'loading_components/calendar_entries_list_loading.dart';

class CalendarContent extends StatelessWidget {
  const CalendarContent({
    super.key,
    required this.entries,
    required this.viewType,
    this.isLoading = false,
    this.hasError = false,
    required this.selectedDateTimeRange,
    required this.scrollToDateRequest,
    required this.onRefresh,
  });

  final List<CalendarEntry>? entries;
  final CalendarViewType viewType;
  final bool isLoading;
  final bool hasError;
  final DateTimeRange selectedDateTimeRange;
  final int scrollToDateRequest;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_8),
        child: CalendarListLoading(),
      );
    }

    if (hasError) {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LmuEmptyState(
            type: EmptyStateType.generic,
            title: 'Error loading Events',
            description: 'There was an error while loading your calendar events. Please try again later.',
          ),
          const SizedBox(height: LmuSizes.size_32),
          LmuButton(
            title: 'Refresh',
            leadingIcon: Icons.refresh,
            onTap: onRefresh,
            size: ButtonSize.large,
            emphasis: ButtonEmphasis.primary,
          ),
        ],
      ));
    }

    if (entries == null || entries?.isEmpty == true) {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LmuEmptyState(
            type: EmptyStateType.noSearchResults,
            title: 'No Events found',
            description: 'No events are available for the selected date range.',
          ),
          const SizedBox(height: LmuSizes.size_32),
          LmuButton(
            title: 'Add new Entry',
            leadingIcon: LucideIcons.calendar_plus,
            onTap: onRefresh,
            size: ButtonSize.large,
            emphasis: ButtonEmphasis.primary,
          ),
        ],
      ));
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
