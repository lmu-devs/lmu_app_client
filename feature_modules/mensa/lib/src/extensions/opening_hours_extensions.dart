import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';

import '../repository/api/models/mensa/mensa_opening_hours.dart';

enum MensaStatus {
  openingSoon,
  open,
  closingSoon,
  closed,
}

// Add the new extension for day mapping
extension MensaOpeningHoursExtension on MensaOpeningHours {
  String mapToDay(AppLocalizations localizations) {
    switch (day) {
      case "MONDAY":
        return localizations.monday;
      case "TUESDAY":
        return localizations.tuesday;
      case "WEDNESDAY":
        return localizations.wednesday;
      case "THURSDAY":
        return localizations.thursday;
      case "FRIDAY":
        return localizations.friday;
      default:
        return day;
    }
  }
}

extension OpeningHoursExtension on List<MensaOpeningHours> {
  MensaStatus get mensaStatus {
    final now = DateTime.now();
    final todaysHours = _getTodaysHours(now);

    if (todaysHours == null) return MensaStatus.closed;

    final startTime = _parseTime(todaysHours.startTime, now);
    final endTime = _parseTime(todaysHours.endTime, now);
    final closingSoonThreshold = endTime.subtract(const Duration(minutes: 30));
    if (now.isBefore(startTime)) {
      return MensaStatus.openingSoon;
    } else if (now.isAfter(startTime) && now.isBefore(closingSoonThreshold)) {
      return MensaStatus.open;
    } else if (now.isAfter(closingSoonThreshold) && now.isBefore(endTime)) {
      return MensaStatus.closingSoon;
    } else {
      return MensaStatus.closed;
    }
  }

  String get closingTime {
    final todaysHours = _getTodaysHours(DateTime.now());
    if (todaysHours == null) return "";

    final endTime = _parseTime(todaysHours.endTime, DateTime.now());
    return "${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}";
  }

  String get openingTime {
    final todaysHours = _getTodaysHours(DateTime.now());
    if (todaysHours == null) return "";

    final startTime = _parseTime(todaysHours.startTime, DateTime.now());
    return "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}";
  }

  MensaOpeningHours? _getTodaysHours(DateTime now) {
    const dayMap = {
      DateTime.monday: "MONDAY",
      DateTime.tuesday: "TUESDAY",
      DateTime.wednesday: "WEDNESDAY",
      DateTime.thursday: "THURSDAY",
      DateTime.friday: "FRIDAY",
    };

    final today = dayMap[now.weekday];
    if (today == null) return null;

    return firstWhereOrNull((element) => element.day == today);
  }

  DateTime _parseTime(String time, DateTime referenceDate) {
    final parts = time.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(referenceDate.year, referenceDate.month, referenceDate.day, hour, minute);
  }
}

extension MensaStatusExtension on MensaStatus {
  Color color(LmuColors colors) {
    switch (this) {
      case MensaStatus.open:
        return colors.successColors.textColors.strongColors.base;
      case MensaStatus.closed:
      case MensaStatus.openingSoon:
        return colors.neutralColors.textColors.mediumColors.base;
      case MensaStatus.closingSoon:
        return colors.warningColors.textColors.strongColors.base;
    }
  }

  String text(
    CanteenLocalizations localizations, {
    required List<MensaOpeningHours> openingHours,
    bool short = false,
  }) {
    switch (this) {
      case MensaStatus.open:
      case MensaStatus.closingSoon:
        return localizations.openUntil(openingHours.closingTime);
      case MensaStatus.closed:
        return localizations.closed;
      case MensaStatus.openingSoon:
        if (short) {
          return localizations.openingSoon(openingHours.openingTime);
        }
        return localizations.openDetails(openingHours.openingTime, openingHours.closingTime);
    }
  }
}
