import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatFullDate(DateTime date, BuildContext context) {
    return DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString()).format(date);
  }

  static String formatShortDate(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final day = DateFormat.E(locale).format(date);
    final datePart = DateFormat("d. MMMM ''yy", locale).format(date);
    return '$day, $datePart';
  }

  static String formatTime(DateTime time, BuildContext context) {
    return DateFormat.Hm(Localizations.localeOf(context).toString()).format(time);
  }

  static String getRelativeDayLabel(DateTime date, BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);

    if (d == today) return 'Heute, ';
    if (d == today.subtract(const Duration(days: 1))) return 'Gestern, ';
    if (d == today.add(const Duration(days: 1))) return 'Morgen, ';
    return '';
  }

  /// Returns a human-readable duration like "1 Std 30 Min" or "3 Tage"
  static String formatDuration(Duration duration, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final days = duration.inDays;

    if (duration.inMinutes < 1) {
      return locale == 'de' ? 'weniger als 1 Min' : 'less than 1 min';
    }

    if (days >= 1) {
      return locale == 'de' ? '$days ${days == 1 ? "Tag" : "Tage"}' : '$days ${days == 1 ? "day" : "days"}';
    }

    String hourPart = hours > 0 ? (locale == 'de' ? '$hours Std' : '$hours h') : '';
    String minutePart = minutes > 0 ? (locale == 'de' ? '$minutes Min' : '$minutes min') : '';

    return [hourPart, minutePart].where((part) => part.isNotEmpty).join(' ');
  }
}
