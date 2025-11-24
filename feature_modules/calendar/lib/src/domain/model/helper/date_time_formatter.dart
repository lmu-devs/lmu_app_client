import 'package:core/themes.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

String get _currentLocale => GetIt.I<LanguageProvider>().locale.toString();

class DateTimeFormatter {
  /// Returns a formatted full date string with the day of the week, day, month, and year.
  ///
  /// This uses the [_currentLocale] to produce locale-aware output.
  ///
  /// Example outputs:
  ///  - en_US: "Monday, January 1, 2025"
  ///  - de_DE: "Montag, 1. Januar 2025"
  ///
  static String formatFullDate(DateTime date) {
    return DateFormat.yMMMMEEEEd(_currentLocale).format(date);
  }

  /// Returns a formatted full date string with the relative day of the week, day, month, and whole year.
  ///
  /// This uses the [_currentLocale] to produce locale-aware output.
  ///
  /// Example outputs:
  ///  - en_US: "Monday / Yesterday / Today / Tomorrow, 1. January 2025"
  ///  - de_DE: "Montag / Gestern / Heute / Morgen , 1. Januar 2025"
  ///
  static String formatFullDateRelative(DateTime date, {bool? stillWithWeekdayName}) {
    String day = formatRelativeWeekdayName(date, stillWithWeekdayName: stillWithWeekdayName);
    final datePart = DateFormat.yMMMMEEEEd(_currentLocale).format(date);
    return '$day, $datePart';
  }

  /// Returns a formatted date string with the day of the week, day, month, and short year.
  ///
  /// This uses the [_currentLocale] to produce locale-aware output, including the day of the week.
  ///
  /// Example outputs:
  ///  - en_US: "Monday, 1. January '25"
  ///  - de_DE: "Montag, 1. Januar '25"
  ///
  static String formatShortDate(DateTime date) {
    final weekday = DateFormat('EEEE', _currentLocale).format(date);
    final datePart = DateFormat("d. MMMM ''yy", _currentLocale).format(date);
    return '$weekday, $datePart';
  }

  /// Returns a formatted date string with the day of the week, day, month, and short year.
  ///
  /// This uses the [_currentLocale] to produce locale-aware output, including the day of the week.
  ///
  /// Example outputs:
  ///  - en_US: "Monday, 1. Jan '25"
  ///  - de_DE: "Montag, 1. Jan '25"
  /// [withYearIfDifferent]
  ///   - If `true`, appends the short year when [date] is not in the current year.
  ///   - If `false` (default), only the dayname, date, and month is shown, even if the year differs.
  ///
  static String formatShorterDate(DateTime date, {bool? withYearIfDifferent}) {
    final bool sameYear = date.year == DateTime.now().year;
    withYearIfDifferent ??= false;
    final String format = (!sameYear && withYearIfDifferent) ? "EE, d. MMM ''yy" : "EE, d. MMM";
    return DateFormat(format, _currentLocale).format(date);
  }

  /// Returns a formatted date string with the relative day of the week, day, month, and short year.
  ///
  /// This uses the [_currentLocale] to produce locale-aware output, including the day of the week.
  ///
  /// Example outputs:
  ///  - en_US: "Monday / Yesterday / Today / Tomorrow, 1. January '25"
  ///  - de_DE: "Montag / Gestern / Heute / Morgen , 1. Januar '25"
  ///
  static String formatShortDateRelative(DateTime date, {bool? stillWithWeekdayName}) {
    String day = formatRelativeWeekdayName(date, stillWithWeekdayName: stillWithWeekdayName);
    final bool sameYear = date.year == DateTime.now().year;
    final String format = sameYear ? "d. MMMM" : "d. MMMM ''yy";
    final datePart = DateFormat(format, _currentLocale).format(date);
    return '$day, $datePart';
  }

  /// Returns the month name, optionally followed by a short year if it differs from the current year.
  ///
  /// The output is locale-aware, using the current [_currentLocale].
  ///
  /// Example outputs:
  ///  - en_US: "January" or "January '27"
  ///  - de_DE: "Januar" or "Januar '27"
  ///
  /// [withYearIfDifferent]
  ///   - If `true`, appends the short year when [date] is not in the current year.
  ///   - If `false` (default), only the month name is shown, even if the year differs.
  ///
  static String formatMonthName(DateTime date, {bool? withYearIfDifferent}) {
    final bool sameYear = date.year == DateTime.now().year;
    withYearIfDifferent ??= false;
    final String format = (!sameYear && withYearIfDifferent) ? "MMMM ''yy" : "MMMM";
    return DateFormat(format, _currentLocale).format(date);
  }

  /// Returns a formatted date string with day and month (e.g., "02. Mai" or "15. Dezember").
  ///
  /// This uses the [_currentLocale] to produce locale-aware output.
  ///
  /// Example outputs:
  ///  - en_US: "May 2"
  ///  - de_DE: "02. Mai"
  ///
  static String formatDayMonth(DateTime date) {
    return DateFormat('dd. MMMM', _currentLocale).format(date);
  }

  /// Formats a [DateTime] object to a localized relative date string (e.g., "Today", "Yesterday").
  /// This uses the [_currentLocale] to produce locale-aware output.
  ///
  /// Example outputs:
  ///  - en_US: "Monday / Heute / Gestern / Morgen"
  ///  - de_DE: "Montag / Today / Yesterday / Tomorrow"
  ///
  static String formatRelativeWeekdayName(DateTime date, {bool? stillWithWeekdayName}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    final locale = _currentLocale.split('_').first; // e.g., 'de' from 'de_DE'

    // TODO: write these locale into the generated locale files
    final translations = {
      'en': {
        'today': 'Today',
        'yesterday': 'Yesterday',
        'tomorrow': 'Tomorrow',
      },
      'de': {
        'today': 'Heute',
        'yesterday': 'Gestern',
        'tomorrow': 'Morgen',
      },
    };

    String? relative;
    if (target == today) {
      relative = translations[locale]?['today'];
    } else if (target == today.subtract(const Duration(days: 1))) {
      relative = translations[locale]?['yesterday'];
    } else if (target == today.add(const Duration(days: 1))) {
      relative = translations[locale]?['tomorrow'];
    }

    if (relative != null) {
      if (stillWithWeekdayName == true) {
        return '$relative, ${DateFormat('EEEE', _currentLocale).format(date)}';
      }
      return relative;
    } else {
      // Fallback to weekday name in locale
      return DateFormat('EEEE', _currentLocale).format(date);
    }
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
