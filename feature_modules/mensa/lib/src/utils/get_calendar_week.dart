import 'mensa_day.dart';

int getCalendarWeek(MensaDay mensaDay) {
  /// ISO 8601 Standard
  final jan4 = DateTime(mensaDay.year, 1, 4);

  final firstMonday = jan4.subtract(Duration(days: jan4.weekday - 1));
  final dayDifference = mensaDay.difference(firstMonday).inDays;

  return (dayDifference / 7).floor() + 1;
}
