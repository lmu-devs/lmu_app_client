import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/mock_events.dart';
import '../component/calendar_custom_appbar.dart';
import '../component/calender_content.dart';
import '../component/date_picker_content.dart';
import '../viewmodel/calendar_page_driver.dart';

class CalendarPage extends DrivableWidget<CalendarPageDriver> {
  CalendarPage({super.key});
  // Switch between mock and real data
  static const _useMockData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCalendarAppBar(
        currentViewType: driver.viewType,
        onViewTypeSelected: (viewType) => driver.onCalendarViewTypeChanged(viewType),
        currentSelectedDateTimeRange: 'August', // TODO: not hardcoded
        isExpanded: driver.isDatePickerExpanded,
        onExpandDatePickerPressed: () => driver.onExpandDatePickerPressed(),
      ),
      body: Column(
        children: [
          DatePickerSection(
            isExpanded: driver.isDatePickerExpanded,
            viewType: driver.viewType,
            selectedDateTimeRange: driver.selectedDateTimeRange,
            onDateSelected: (date) => driver.onDateTimeRangeSelected(date),
          ),
          Expanded(
            child: CalendarContent(
              entries: _useMockData ? mockCalendarEntries : driver.calendarEntries,
              viewType: driver.viewType,
              isLoading: driver.isLoadingEvents,
              hasError: false, // TODO: driver.hasErrorLoadingEvents state
              selectedDateTimeRange: driver.selectedDateTimeRange,
            ),
          ),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
