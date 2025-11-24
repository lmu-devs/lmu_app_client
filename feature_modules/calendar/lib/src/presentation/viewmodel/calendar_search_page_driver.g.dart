// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_search_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestCalendarSearchPageDriver extends TestDriver
    implements CalendarSearchPageDriver {
  @override
  List<CalendarEntry> get allCalendarEntries => [];

  @override
  List<String> get recentSearchIds => [];

  @override
  CalendarEntry? getEntry(String id) {
    return null;
  }

  @override
  Future<void> updateRecentSearches(List<String> recentSearchIds) {
    return Future.value();
  }
}

class $CalendarSearchPageDriverProvider
    extends WidgetDriverProvider<CalendarSearchPageDriver> {
  @override
  CalendarSearchPageDriver buildDriver() {
    return CalendarSearchPageDriver();
  }

  @override
  CalendarSearchPageDriver buildTestDriver() {
    return _$TestCalendarSearchPageDriver();
  }
}
