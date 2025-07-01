import 'package:flutter/material.dart';

extension DateTimeRangeExtension on DateTimeRange {
  /// Converts a [DateTimeRange] to a [DateTime] if the range is within a single day.
  /// Throws an [ArgumentError] if the range spans multiple days.
  DateTime get dateTimeFromSingleDayRange {
    if (start.year == end.year && start.month == end.month && start.day == end.day) {
      return DateTime(start.year, start.month, start.day);
    } else {
      throw ArgumentError('DateTimeRange is not within a single day.');
    }
  }
}
