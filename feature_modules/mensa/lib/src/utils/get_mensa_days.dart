import 'package:mensa/src/utils/mensa_day.dart';

List<MensaDay> getMensaDays({bool excludeWeekend = true}) {
  List<MensaDay> mensaDays = [];

  MensaDay now = MensaDay.now();
  MensaDay firstDayOfMonth = MensaDay(now.year, now.month, 1);
  MensaDay lastDayOfMonth = MensaDay(now.year, now.month + 1, 0);

  MensaDay startOfCurrentWeek = now.subtractDuration(Duration(days: now.weekday - 1));
  MensaDay startOfFirstWeekToInclude =
      startOfCurrentWeek.isBefore(firstDayOfMonth) ? firstDayOfMonth : startOfCurrentWeek;
  MensaDay endOfLastWeek = lastDayOfMonth.addDuration(Duration(days: DateTime.sunday - lastDayOfMonth.weekday));

  if (excludeWeekend && (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday)) {
    startOfFirstWeekToInclude = startOfFirstWeekToInclude.addDuration(const Duration(days: 7));
  }

  for (MensaDay day = startOfFirstWeekToInclude;
      day.isBefore(endOfLastWeek) || day.isAtSameMomentAs(endOfLastWeek);
      day = day.addDuration(const Duration(days: 1))) {
    if (excludeWeekend && (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday)) {
      continue;
    }
    mensaDays.add(day);
  }

  return mensaDays;
}
