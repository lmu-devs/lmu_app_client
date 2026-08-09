import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/calendar_custom_appbar.dart';
import '../component/calender_content.dart';
import '../component/date_picker_content.dart';
import '../viewmodel/calendar_page_driver.dart';

class CalendarPage extends DrivableWidget<CalendarPageDriver> {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCalendarAppBar(
        currentViewType: driver.viewType,
        onViewTypeSelected: (viewType) => driver.onCalendarViewTypeChanged(viewType),
        currentSelectedDateTimeRange: driver.selectedDateTimeRange!,
        isExpanded: driver.isDatePickerExpanded,
        onExpandDatePickerPressed: () => driver.onExpandDatePickerPressed(),
        onChangeToTodayPressed: () => driver.onChangeToTodayPressed(),
        onSearchPressed: () => driver.onSearchPressed(context),
        onAddCalendarEntryPressed: () => driver.onCreatePressed(context),
        isLoading: driver.isLoadingEvents,
        hasError: driver.hasErrorLoadingEvents,
      ),
      body: Column(
        children: [
          DatePickerSection(
            isExpanded: driver.isDatePickerExpanded,
            viewType: driver.viewType,
            selectedDateTimeRange: driver.selectedDateTimeRange!,
            onDateSelected: (date) => driver.onDateTimeRangeSelected(date),
            entries: driver.calendarEntries,
            isLoading: driver.isLoadingEvents,
            hasError: driver.hasErrorLoadingEvents,
          ),
          Expanded(
            child: CalendarContent(
              entries: driver.calendarEntries,
              viewType: driver.viewType,
              isLoading: driver.isLoadingEvents,
              hasError: driver.hasErrorLoadingEvents,
              onRefresh: () => driver.loadEvents(),
              selectedDateTimeRange: driver.selectedDateTimeRange!,
              scrollToDateRequest: driver.scrollToDateRequest,
            ),
          ),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
