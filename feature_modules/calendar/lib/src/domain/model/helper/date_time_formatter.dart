import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

String get _currentLocale => GetIt.I<LanguageProvider>().locale.toString();

class DateTimeFormatter {
  static String formatFullDate(DateTime date, BuildContext context) {
    return DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString()).format(date);
  }

  /// Returns a formatted date string with the day of the week, day, month, and year.
  ///
  /// This uses the [_currentLocale] to produce locale-aware output, including the day of the week.
  ///
  /// Example outputs:
  ///  - en_US: "Monday / Yesterday / Today / Tomorrow, 1. January '25"
  ///  - de_DE: "Montag / Gestern / Heute / Morgen , 1. Januar '25"
  ///
  static String formatShortDate(DateTime date) {
    final day = DateFormat.E(_currentLocale).format(date);
    final datePart = DateFormat("d. MMMM ''yy", _currentLocale).format(date);
    return '$day, $datePart';
  }

  /// Formats a [DateTime] object to a localized 12-hour time string (e.g., "1:45 PM").
  ///
  /// This uses the [_currentLocale] to produce locale-aware output, including AM/PM suffixes.
  ///
  /// Example outputs:
  ///   - en_US: "1:45 PM"
  ///   - fr_FR: "13:45"  (Note: some locales still use 24-hour format even with `.jm`)
  ///   - ar_EG: "١:٤٥ م"
  ///
  /// Use this when the user's locale prefers 12-hour time with AM/PM.
  static String formatTimeForLocale(DateTime time) {
    final locale = _currentLocale.toString();
    return DateFormat.jm(locale).format(time);
  }

  /// Formats a [DateTime] object to a localized 24-hour time string (e.g., "13:45").
  ///
  /// This uses the [_currentLocale] to produce locale-aware output using the 24-hour format.
  ///
  /// Example outputs:
  ///   - en_US: "13:45"
  ///   - de_DE: "13:45"
  ///   - fr_FR: "13:45"
  ///
  /// Use this when you want a consistent 24-hour time format regardless of AM/PM preference.
  static String formatTime24h(DateTime time) {
    final locale = _currentLocale.toString();
    return DateFormat.Hm(locale).format(time);
  }

  static String formatDateTimeRange(DateTime start, DateTime end) {
    final startTime = '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    final endTime = '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    return '$startTime - $endTime';
  }
}
