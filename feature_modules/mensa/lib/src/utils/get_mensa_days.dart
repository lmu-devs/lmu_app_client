import 'mensa_day.dart';

List<MensaDay> getMensaDays({bool excludeWeekend = true}) {
  List<MensaDay> mensaDays = [];

  MensaDay now = MensaDay.now();
  MensaDay lastDayOfMonth = MensaDay(now.year, now.month + 1, 0);

  MensaDay startOfFirstWeekToInclude = now.subtractDuration(Duration(days: now.weekday - 1));
  MensaDay endOfLastWeek = lastDayOfMonth.subtractDuration(Duration(days: lastDayOfMonth.weekday - DateTime.friday));

  if (excludeWeekend) {
    while (startOfFirstWeekToInclude.weekday == DateTime.saturday ||
        startOfFirstWeekToInclude.weekday == DateTime.sunday) {
      startOfFirstWeekToInclude = startOfFirstWeekToInclude.addDuration(const Duration(days: 1));
    }
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
