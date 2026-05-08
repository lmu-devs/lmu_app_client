import 'package:core/api.dart';

import '../repository/api/models/sports_course.dart';

extension SportsCourseExtension on SportsCourse {
  bool get runsToday => runsOnDate(DateTime.now());

  bool runsOnDate(DateTime date) {
    try {
      final courseStartDate = DateTime.parse(startDate);
      final courseEndDate = DateTime.parse(endDate);

      final targetDate = DateTime(date.year, date.month, date.day);
      final courseStart = DateTime(courseStartDate.year, courseStartDate.month, courseStartDate.day);
      final courseEnd = DateTime(courseEndDate.year, courseEndDate.month, courseEndDate.day);

      final bool isInDateRange = !(targetDate.isBefore(courseStart) || targetDate.isAfter(courseEnd));

      if (!isInDateRange) {
        return false;
      }

      final targetWeekday = _mapDateTimeWeekday(date.weekday);
      final bool hasMatchingTimeslot = timeSlots.any((slot) => slot.day == targetWeekday);

      return hasMatchingTimeslot;
    } catch (e) {
      return false;
    }
  }

  Weekday _mapDateTimeWeekday(int dateTimeWeekday) {
    switch (dateTimeWeekday) {
      case DateTime.monday:
        return Weekday.monday;
      case DateTime.tuesday:
        return Weekday.tuesday;
      case DateTime.wednesday:
        return Weekday.wednesday;
      case DateTime.thursday:
        return Weekday.thursday;
      case DateTime.friday:
        return Weekday.friday;
      case DateTime.saturday:
        return Weekday.saturday;
      case DateTime.sunday:
        return Weekday.sunday;
      default:
        throw ArgumentError('Invalid weekday integer: $dateTimeWeekday');
    }
  }
}
