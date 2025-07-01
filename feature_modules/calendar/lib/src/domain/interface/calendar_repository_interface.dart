import '../model/calendar.dart';
import '../model/calendar_entry.dart';

abstract class CalendarRepositoryInterface {
  Future<Calendar> getCalendar();

  Future<Calendar?> getCachedCalendar();

  Future<List<CalendarEntry>> getCalendarEvents();

  Future<List<CalendarEntry>?> getCachedCalendarEntries();

  Future<void> deleteCalendar();
}
