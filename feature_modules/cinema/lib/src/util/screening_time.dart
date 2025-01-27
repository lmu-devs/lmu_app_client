import 'package:core/api.dart';
import 'package:core/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String getScreeningTime({
  required BuildContext context,
  required String time,
}) {
  final DateTime parsedTime = DateTime.parse(time);
  final DateTime now = DateTime.now();

  final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

  if (parsedTime.year == now.year && parsedTime.month == now.month && parsedTime.day == now.day) {
    return '${context.locals.cinema.todayScreening} • ${DateFormat('HH:mm').format(parsedTime)}';
  }

  final DateTime tomorrow = now.add(const Duration(days: 1));
  if (parsedTime.year == tomorrow.year && parsedTime.month == tomorrow.month && parsedTime.day == tomorrow.day) {
    return '${context.locals.cinema.tomorrowScreening} • ${DateFormat('HH:mm').format(parsedTime)}';
  }

  if (parsedTime.isAfter(startOfWeek) && parsedTime.isBefore(endOfWeek.add(const Duration(days: 1)))) {
    final Weekday weekday = Weekday.values[parsedTime.weekday - 1];
    return '${weekday.localizedWeekday(context.locals.app)} • ${DateFormat('HH:mm').format(parsedTime)}';
  }

  return DateFormat('dd.MM.yyyy • HH:mm').format(parsedTime);
}
