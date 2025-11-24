// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestCalendarPageDriver extends TestDriver
    implements CalendarPageDriver {
  @override
  bool get isLoadingEvents => false;

  @override
  String get largeTitle => ' ';

  @override
  bool get isDatePickerExpanded => false;

  @override
  CalendarViewType get viewType => CalendarViewType.list;

  @override
  DateTimeRange<DateTime>? get selectedDateTimeRange => null;

  @override
  int get scrollToDateRequest => 0;

  @override
  List<CalendarEntry> get calendarEntries => [];

  @override
  Future<void> loadEvents() {
    return Future.value();
  }

  @override
  void onCalendarViewTypeChanged(CalendarViewType mode) {}

  @override
  void onDateTimeRangeSelected(DateTimeRange<DateTime> dateRange) {}

  @override
  void onExpandDatePickerPressed() {}

  @override
  void onChangeToTodayPressed() {}

  @override
  void onEventTap(CalendarEntry event, BuildContext context) {}

  @override
  void onAddEventPressed() {}

  @override
  void onTestScreenPressed(BuildContext context) {}

  @override
  void onSearchPressed(BuildContext context) {}

  @override
  void onCreatePressed(BuildContext context) {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $CalendarPageDriverProvider
    extends WidgetDriverProvider<CalendarPageDriver> {
  @override
  CalendarPageDriver buildDriver() {
    return CalendarPageDriver();
  }

  @override
  CalendarPageDriver buildTestDriver() {
    return _$TestCalendarPageDriver();
  }
}
