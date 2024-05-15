List<DateTime> getMensaDays({bool excludeWeekend = true, bool excludePastDates = false}) {
  List<DateTime> mensaDays = [];

  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));
  DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

  for (int i = 0; i < lastDayOfMonth.day; i++) {
    DateTime day = firstDayOfMonth.add(Duration(days: i));
    if (excludeWeekend && (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday)) {
      continue;
    }
    if (excludePastDates && day.isBefore(DateTime(now.year, now.month, now.day))) {
      if (day.year == yesterday.year && day.month == yesterday.month && day.day == yesterday.day) {
        mensaDays.add(day);
      }
      continue;
    }
    mensaDays.add(day);
  }

  return mensaDays;
}