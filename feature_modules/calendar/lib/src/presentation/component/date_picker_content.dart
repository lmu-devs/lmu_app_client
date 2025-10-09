import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_view_type.dart';
import '../../domain/model/mock_events.dart';
import '../component/week_selector.dart';
import 'month_selector.dart';

class DatePickerSection extends StatelessWidget {
  const DatePickerSection({
    super.key,
    required this.isExpanded,
    required this.viewType,
    required this.selectedDateTimeRange,
    required this.onDateSelected,
  });
  final bool isExpanded;
  final CalendarViewType viewType;
  final DateTimeRange selectedDateTimeRange;
  final ValueChanged<DateTimeRange> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.colors.neutralColors.borderColors.seperatorLight,
              width: 1.0,
            ),
          ),
        ),
        child: isExpanded ? _buildPicker(context) : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildPicker(BuildContext context) {
    if (viewType == CalendarViewType.list) {
      return MonthDaySelector(
          selectedDate: selectedDateTimeRange.start,
          onDateTimeRangeSelected: (dateRange) => onDateSelected(dateRange),
          entries: mockCalendarEntries);
    } else if (viewType == CalendarViewType.week) {
      return const Text('Date picker in WeekView is WIP');
    } else {
      return WeekdaySelector(
        selectedDate: selectedDateTimeRange.start,
        onDateTimeRangeSelected: (dateRange) => onDateSelected(dateRange),
        entries: mockCalendarEntries,
      );
    }
  }
}
