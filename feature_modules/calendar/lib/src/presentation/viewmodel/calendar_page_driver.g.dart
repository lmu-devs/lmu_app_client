// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"
// This file was generated with widget_driver_generator version "1.3.5"

class _$TestCalendarPageDriver extends TestDriver implements CalendarPageDriver {
  @override
  bool get isLoadingEvents => false;

  @override
  String get largeTitle => ' ';

  @override
  CalendarViewType get viewType => CalendarViewType.types[0];

  @override
  DateTimeRange<DateTime> get selectedDate => DateTimeRange<DateTime>(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)),
      );

  @override
  List<CalendarEntry>? get calendarEntries => [];

  @override
  Future<void> loadEvents() {
    return Future.value();
  }

  @override
  void onCalendarViewTypeChanged(CalendarViewType mode) {}

  @override
  void onDateSelected(DateTimeRange<DateTime> dateRange) {}

  @override
  void onEventTap(CalendarEntry event, BuildContext context) {}
  void onEventTap(CalendarEntry event, BuildContext context) {}

  @override
  void onAddEventPressed() {}
  void onAddEventPressed() {}

  @override
  void onTestScreenPressed(BuildContext context) {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $CalendarPageDriverProvider extends WidgetDriverProvider<CalendarPageDriver> {
  @override
  CalendarPageDriver buildDriver() {
    return CalendarPageDriver();
  }

  @override
  CalendarPageDriver buildTestDriver() {
    return _$TestCalendarPageDriver();
  }
}
