import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/calendar_view_type.dart';
import '../../domain/model/mock_events.dart';
import '../component/calendar_custom_appbar.dart';
import '../component/calendar_entries_list.dart';
import '../component/week_selector.dart';
import '../viewmodel/calendar_page_driver.dart';
import 'calendar_test-page.dart';

class CalendarPage extends DrivableWidget<CalendarPageDriver> {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCalendarAppBar(
        currentViewType: driver.viewType,
        onViewTypeSelected: (viewType) => driver.onCalendarViewTypeChanged(viewType),
        currentSelectedMonth: 'August',
      ),
      body: SizedBox(
        height: 700,
        child: Column(
          children: [
            if (driver.viewType == CalendarViewType.day) _buildWeekPicker(),
            Expanded(child: _buildCalendarEntriesView()),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarEntriesView() {
    // ! Uncommented because we want to work with mock data for now

    // if (driver.isLoadingEvents) {
    //   return const Column(
    //     children: [
    //       CalendarCardLoading(),
    //       CalendarCardLoading(),
    //       CalendarCardLoading(),
    //     ],
    //   );
    // }

    // if (driver.hasErrorLoadingEvents) {
    //   return const Center(child: Text('Error loading events'));
    // }

    // if (driver.calendarEntries == null || driver.calendarEntries!.isEmpty) {
    //   return const Center(child: Text('No events found.'));
    // }
    if (driver.viewType == CalendarViewType.list) {
      return CalendarEntriesListView(
        entries: mockCalendarEntries,
        // entries: driver.calendarEntries!,
      );
    } else {
      return CalendarEntriesDayView(
        entries: mockCalendarEntries,
        // entries: driver.calendarEntries!,
      );
    }
  }

  Widget _buildWeekPicker() {
    final startOfWeek = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );
    driver.selectedDate.dateTimeFromSingleDayRange;
    startOfWeek.subtract(
      Duration(days: startOfWeek.weekday - 1),
    );

    return WeekPicker(
        selectedDate: driver.selectedDate.dateTimeFromSingleDayRange,
        onDateSelected: (date) => driver.onDateSelected(date));
  }

  @override
  WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
