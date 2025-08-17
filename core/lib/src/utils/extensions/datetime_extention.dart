import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../themes/language_provider.dart';

String get _currentLocale => GetIt.I<LanguageProvider>().locale.toString();

extension DateTimeExtension on DateTime {
  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int get weekOfYear {
    int dayOfYear = int.parse(DateFormat("D").format(this));
    return ((dayOfYear - weekday + 10) / 7).floor();
  }

  String get monthName {
    return DateFormat.MMMM(_currentLocale).format(this);
  }

  String get weekdayName {
    return DateFormat.EEEE(_currentLocale).format(this);
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day + 1).subtract(const Duration(seconds: 1));
  }

  DateTime get startOfWeek {
    return startOfDay.subtract(Duration(days: weekday - DateTime.monday));
  }

  DateTime get endOfWeek {
    return startOfDay.add(Duration(days: DateTime.sunday - weekday + 1));
  }

  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  DateTime get startOfPreviousMonth {
    return startOfMonth.subtract(const Duration(days: 1)).startOfMonth;
  }

  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0);
  }

  DateTime get startOfYear {
    return DateTime(year);
  }

  DateTime get endOfYear {
    return DateTime(year, 12).endOfMonth;
  }

  DateTime get startOfDecade {
    int newYear = year;
    while (newYear % 10 != 0) {
      newYear--;
    }
    return DateTime(newYear, 12).endOfMonth;
  }

  DateTime get endOfDecade {
    int newYear = year + 1;
    while (newYear % 10 != 0) {
      newYear++;
    }
    return DateTime(newYear);
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isSameDay(DateTime dateTime) {
    return DateTime(year, month, day) == DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  bool isNextDay(DateTime dateTime) {
    final nextDay = DateTime(year, month, day).add(const Duration(days: 1));
    return nextDay.year == dateTime.year && nextDay.month == dateTime.month && nextDay.day == dateTime.day;
  }

  bool isSameMonth(DateTime dateTime) {
    return DateTime(year, month) == DateTime(dateTime.year, dateTime.month);
  }

  bool isSameYear(DateTime dateTime) {
    return DateTime(year) == DateTime(dateTime.year);
  }

  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  bool isInTimeFrame({required DateTime? firstDate, required DateTime? lastDate}) {
    if (firstDate != null && lastDate != null) {
      return (firstDate.isBeforeOrEqualTo(this) && lastDate.isAfterOrEqualTo(this));
    } else {
      if (lastDate != null && firstDate == null) {
        return lastDate.isAfterOrEqualTo(this);
      }
      if (firstDate != null && lastDate == null) {
        return firstDate.isBeforeOrEqualTo(this);
      }
    }
    return true;
  }

  DateTime addMonth() {
    return DateTime(year, month + 1, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime subtractMonth() {
    return DateTime(year, month - 1, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime addQuarter() {
    return addMonth().addMonth().addMonth();
  }

  DateTime subtractQuarter() {
    return subtractMonth().subtractMonth().subtractMonth();
  }

  DateTime addYear() {
    return DateTime(year + 1, month, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime subtractYear() {
    return DateTime(year - 1, month, day, hour, minute, second, millisecond, microsecond);
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final isAfter = isAfterOrEqualTo(fromDateTime);
    final isBefore = isBeforeOrEqualTo(toDateTime);
    return isAfter && isBefore;
  }

  DateTime setYear(int newYear) {
    return DateTime(newYear, month, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime setMonth(int newMonth) {
    return DateTime(year, newMonth, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime setDay(int newDay) {
    return DateTime(year, month, newDay, hour, minute, second, millisecond, microsecond);
  }

  DateTime setHour(int newHour) {
    return DateTime(year, month, day, newHour, minute, second, millisecond, microsecond);
  }

  DateTime setMinute(int newMinute) {
    return DateTime(year, month, day, hour, newMinute, second, millisecond, microsecond);
  }

  DateTime setSecond(int newSecond) {
    return DateTime(year, month, day, hour, minute, newSecond, millisecond, microsecond);
  }

  DateTime setMillisecond(int newMillisecond) {
    return DateTime(year, month, day, hour, minute, second, newMillisecond, microsecond);
  }

  DateTime setMicrosecond(int newMicrosecond) {
    return DateTime(year, month, day, hour, minute, second, millisecond, newMicrosecond);
  }

  /// Returns the number of days in the month of the given [DateTime].
  static int daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  /// Returns the weekday of the first day of the month of the given [DateTime].
  static int firstDayWeekday(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday;
  }

  /// Converts a [DateTime] to a [DateTimeRange] covering the entire day.
  /// The range starts at 00:00:01 and ends at 23:59:59 of the given day.
  DateTimeRange get dateTimeRangeFromDateTime {
    return DateTimeRange(start: startOfDay, end: endOfDay);
  }
}
