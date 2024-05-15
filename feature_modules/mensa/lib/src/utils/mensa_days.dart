List<DateTime> getMensaDays({bool excludeWeekend = true}) {
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
    if (day.isBefore(DateTime(now.year, now.month, now.day))) {
      if (day.year == yesterday.year && day.month == yesterday.month && day.day == yesterday.day) {
        mensaDays.add(day);
      }
      continue;
    }
    mensaDays.add(day);
  }

  return mensaDays;
}

bool areMensaDaysEqual(DateTime firstDate, DateTime secondDate) {
  return (firstDate.year == secondDate.year && firstDate.month == secondDate.month && firstDate.day == secondDate.day);
}

String convertMensaDayToText(DateTime mensaDay) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime tomorrow = today.add(const Duration(days: 1));

  if (areMensaDaysEqual(mensaDay, now)) {
    return 'Today';
  } else if (areMensaDaysEqual(mensaDay, tomorrow)) {
    return 'Tomorrow';
  } else {
    return mensaDay.weekday == 1
        ? 'Mo. ${mensaDay.day}'
        : mensaDay.weekday == 2
            ? 'Di. ${mensaDay.day}'
            : mensaDay.weekday == 3
                ? 'Mi. ${mensaDay.day}'
                : mensaDay.weekday == 4
                    ? 'Do. ${mensaDay.day}'
                    : mensaDay.weekday == 5
                        ? 'Fr. ${mensaDay.day}'
                        : mensaDay.weekday == 6
                            ? 'Sa. ${mensaDay.day}'
                            : 'So. ${mensaDay.day}';
  }
}
