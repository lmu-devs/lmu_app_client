import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/cupertino.dart';

import '../model/session_model.dart';

extension SessionModelExtension on SessionModel {

  String formattedTimeText(BuildContext context) {
    final localizations = context.locals;
    final List<String> parts = [];

    parts.add(_mapRhythm(localizations, rhythm));

    if (weekday != null) {
      parts.add(_mapWeekday(weekday!));
    }

    final start = _cleanTime(startingTime);
    final end = _cleanTime(endingTime);

    if (start.isNotEmpty && end.isNotEmpty) {
      parts.add("$start-$end");
    }

    return parts.join(", ");
  }

  String get formattedDurationText {
    final start = _formatDate(durationStart);
    final end = _formatDate(durationEnd);

    if (start.isNotEmpty && end.isNotEmpty) {
      return "$start - $end";
    }

    if (start.isNotEmpty) {
      return start;
    }

    if (end.isNotEmpty) {
      return end;
    }

    return "";
  }

  String _cleanTime(String time) {
    final parts = time.split(':');
    if (parts.length >= 2) {
      return "${parts[0]}:${parts[1]}";
    }
    return time;
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        return "${parts[2]}.${parts[1]}.${parts[0]}";
      }
      return dateStr;
    } catch (e) {
      return dateStr;
    }
  }

  int _getWeekdayNumber(String day) {
    switch (day.toUpperCase()) {
      case 'MONDAY': return DateTime.monday;
      case 'TUESDAY': return DateTime.tuesday;
      case 'WEDNESDAY': return DateTime.wednesday;
      case 'THURSDAY': return DateTime.thursday;
      case 'FRIDAY': return DateTime.friday;
      case 'SATURDAY': return DateTime.saturday;
      case 'SUNDAY': return DateTime.sunday;
      default: throw ArgumentError("Invalid weekday: $weekday");
    }
  }

  String _mapWeekday(String day) {
    final now = DateTime.now();
    final target = _getWeekdayNumber(day);

    int difference = (target - now.weekday) % 7;
    if (difference == 0) difference = 7;

    final weekday = now.add(Duration(days: difference));

    return "${weekday.weekdayName.substring(0, 2)}.";
  }

  String _mapRhythm(LmuLocalizations localizations, String rhythm) {
    final r = rhythm.toLowerCase();
    if (r.contains('woch')) return localizations.courses.weeklyRhythm;
    if (r.contains('einzel')) return localizations.courses.singleDate;
    return rhythm;
  }
}
