import 'package:core/localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum Weekday {
  @JsonValue('MONDAY')
  monday,
  @JsonValue('TUESDAY')
  tuesday,
  @JsonValue('WEDNESDAY')
  wednesday,
  @JsonValue('THURSDAY')
  thursday,
  @JsonValue('FRIDAY')
  friday,
  @JsonValue('SATURDAY')
  saturday,
  @JsonValue('SUNDAY')
  sunday,
}

extension WeekdayToString on Weekday {
  String localizedWeekday(AppLocalizations localizations) {
    return switch (this) {
      Weekday.monday => localizations.monday,
      Weekday.tuesday => localizations.tuesday,
      Weekday.wednesday => localizations.wednesday,
      Weekday.thursday => localizations.thursday,
      Weekday.friday => localizations.friday,
      Weekday.saturday => localizations.saturady,
      Weekday.sunday => localizations.sunday,
    };
  }

  String localizedWeekdayShort(AppLocalizations localizations) {
    return switch (this) {
      Weekday.monday => localizations.monday.substring(0, 2),
      Weekday.tuesday => localizations.tuesday.substring(0, 2),
      Weekday.wednesday => localizations.wednesday.substring(0, 2),
      Weekday.thursday => localizations.thursday.substring(0, 2),
      Weekday.friday => localizations.friday.substring(0, 2),
      Weekday.saturday => localizations.saturady.substring(0, 2),
      Weekday.sunday => localizations.sunday.substring(0, 2),
    };
  }
}
