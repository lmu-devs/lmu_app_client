// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_create_entry_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestCalendarCreateEntryPageDriver extends TestDriver implements CalendarCreateEntryPageDriver {
  @override
  String get pageTitle => 'Neuer Termin';

  @override
  bool get isAllDay => false;

  @override
  Color get selectedColor => Colors.orange;

  @override
  Frequency? get recurrence => Frequency.once;

  @override
  int get intervall => 1;

  @override
  DateTime get untilTime => DateTime.now();

  @override
  String get notificationText => "Keine";

  @override
  DateTime get startTime => DateTime.now();

  @override
  DateTime get endTime => DateTime.now();

  @override
  bool get isSaving => false;

  @override
  void toggleAllDay(bool value) {}

  @override
  void setColor(Color color) {}

  @override
  void setRecurrence(Frequency? value) {}

  @override
  void setNotification(String value) {}

  @override
  void setStartTime(DateTime date) {}

  @override
  void setEndTime(DateTime date) {}

  @override
  void setUntilTime(DateTime date) {}

  @override
  void setIntervall(int value) {}

  @override
  Future<void> saveEntry(BuildContext context) {
    return Future.value();
  }

  @override
  void didInitDriver() {}

  @override
  void dispose() {}
}

class $CalendarCreateEntryPageDriverProvider extends WidgetDriverProvider<CalendarCreateEntryPageDriver> {
  @override
  CalendarCreateEntryPageDriver buildDriver() {
    return CalendarCreateEntryPageDriver();
  }

  @override
  CalendarCreateEntryPageDriver buildTestDriver() {
    return _$TestCalendarCreateEntryPageDriver();
  }
}
