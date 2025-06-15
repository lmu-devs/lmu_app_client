import '../model/calendar.dart';

abstract class CalendarRepositoryInterface {
  Future<Calendar> getCalendar();

  Future<Calendar?> getCachedCalendar();

  Future<void> deleteCalendar();
}
