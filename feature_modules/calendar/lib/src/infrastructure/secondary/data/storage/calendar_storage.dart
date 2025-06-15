import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/calendar_dto.dart';

class CalendarStorage {
  final _calendarKey = 'calendar_data_key';

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

  Future<void> deleteCalendar() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_calendarKey);
  }
}
