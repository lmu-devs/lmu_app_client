import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../themes.dart';

String get _currentLocale => GetIt.I<LanguageProvider>().locale.toString();

enum Weekday {
  @JsonValue('MONDAY')
  monday(DateTime.monday),
  @JsonValue('TUESDAY')
  tuesday(DateTime.tuesday),
  @JsonValue('WEDNESDAY')
  wednesday(DateTime.wednesday),
  @JsonValue('THURSDAY')
  thursday(DateTime.thursday),
  @JsonValue('FRIDAY')
  friday(DateTime.friday),
  @JsonValue('SATURDAY')
  saturday(DateTime.saturday),
  @JsonValue('SUNDAY')
  sunday(DateTime.sunday);

  const Weekday(this.value);
  final int value;

  /// Returns the localized full name of the weekday (e.g., "Monday", "Montag", "Lunedi",...).
  /// But now just calling Weekday.monday or .toString() will return the localized name.,
  /// This is the same as [name] but uses the current locale.
  @override
  String toString() => name;
}

extension WeekdayToString on Weekday {
  // A helper function to get a DateTime object for any given year/month/day
  // that corresponds to the specific weekday. This is needed because
  // DateFormat.EEEE and DateFormat.E format a DateTime object.
  // We can pick an arbitrary date where we know the weekday, e.g.,
  // January 1, 2024 was a Monday.
  DateTime _getDateTimeForWeekday() {
    // January 1, 2024 was a Monday (DateTime.monday = 1)
    final baseDate = DateTime(2024, 1, 1);
    // Calculate the difference in days from Monday to the current weekday
    final int daysToAdd = value - DateTime.monday;
    return baseDate.add(Duration(days: daysToAdd));
  }

  /// Returns the localized full name of the weekday (e.g., "Monday", "Montag", "Lunedi",...).
  get name {
    final fullName = DateFormat.EEEE(_currentLocale).format(_getDateTimeForWeekday());
    if (fullName.isEmpty) return fullName;
    return '${fullName[0].toUpperCase()}${fullName.substring(1)}';
  }

  /// Returns the localized short name of the weekday (e.g., "Mon", "Mo", "Lu", ...).
  get nameShort {
    final shortName = DateFormat.E(_currentLocale).format(_getDateTimeForWeekday());
    if (shortName.isEmpty) return shortName;
    return '${shortName[0].toUpperCase()}${shortName.substring(1)}';
  }
}
