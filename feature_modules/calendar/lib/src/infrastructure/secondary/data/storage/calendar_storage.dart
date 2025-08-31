import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/calendar_dto.dart';
import '../dto/calendar_entry_dto.dart';

class CalendarStorage {
  final _calendarKey = 'calendar_data_key';
  final _calendarEventsKey = 'calendar_entries_data_key';

  Future<void> saveCalendar(CalendarDto calendar) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_calendarKey, jsonEncode(calendar.toJson()));
  }

  Future<CalendarDto?> getCalendar() async {
    final prefs = await SharedPreferences.getInstance();
    final calendarJson = prefs.getString(_calendarKey);
    if (calendarJson == null) return null;
    final calendarMap = jsonDecode(calendarJson);
    return CalendarDto.fromJson(calendarMap);
  }

  Future<List<CalendarEntryDto>?> getCalendarEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final calendarEventsJson = prefs.getString(_calendarEventsKey);
    if (calendarEventsJson == null) return null;
    final List<dynamic> calendarEventsList = jsonDecode(calendarEventsJson);
    return calendarEventsList.map((entry) => CalendarEntryDto.fromJson(entry)).toList();
  }

  Future<void> deleteCalendar() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_calendarKey);
  }
}
