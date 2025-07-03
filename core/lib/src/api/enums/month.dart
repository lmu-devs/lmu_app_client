import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../themes.dart';

String get currentLocale => GetIt.I<LanguageProvider>().locale.toString();

enum Month {
  @JsonValue('JANUARY')
  january(1),
  @JsonValue('FEBRUARY')
  february(2),
  @JsonValue('MARCH')
  march(3),
  @JsonValue('APRIL')
  april(4),
  @JsonValue('MAY')
  may(5),
  @JsonValue('JUNE')
  june(6),
  @JsonValue('JULY')
  july(7),
  @JsonValue('AUGUST')
  august(8),
  @JsonValue('SEPTEMBER')
  september(9),
  @JsonValue('OCTOBER')
  october(10),
  @JsonValue('NOVEMBER')
  november(11),
  @JsonValue('DECEMBER')
  december(12);

  const Month(this.value);
  final int value;

  /// Returns the localized full name of the month (e.g., "January", "Januar", "Gennaio",...).
  /// But now just calling Month.january or toString() will return the localized name.,
  /// This is the same as [name] but uses the current locale.
  @override
  String toString() => name;
}

extension MonthToString on Month {
  // A helper function to get a DateTime object for a specific month.
  // We can pick any year/day, as only the month matters for formatting.
  DateTime _getDateTimeForMonth() {
    return DateTime(2000, value, 1);
  }

  /// Returns the localized full name of the month (e.g., "January", "Januar", "Gennaio",...).
  String get name {
    final fullName = DateFormat.MMMM(currentLocale).format(_getDateTimeForMonth());
    if (fullName.isEmpty) return fullName;
    return '${fullName[0].toUpperCase()}${fullName.substring(1)}';
  }

  /// Returns the localized short name of the month (e.g., "Jan", "Jan", "Gen",...).
  String get nameShort {
    final shortName = DateFormat.MMM(currentLocale).format(_getDateTimeForMonth());
    if (shortName.isEmpty) return shortName;
    return '${shortName[0].toUpperCase()}${shortName.substring(1)}';
  }
}
