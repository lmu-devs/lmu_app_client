import 'package:collection/collection.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';

import '../../mensa.dart';

enum Status {
  openingSoon,
  open,
  closingSoon,
  closed,
  temporarilyClosed,
}

extension WeekdayToString on MensaOpeningDetails {
  String mapToDay(AppLocalizations localizations) {
    switch (day) {
      case Weekday.monday:
        return localizations.monday;
      case Weekday.tuesday:
        return localizations.tuesday;
      case Weekday.wednesday:
        return localizations.wednesday;
      case Weekday.thursday:
        return localizations.thursday;
      case Weekday.friday:
        return localizations.friday;
      case Weekday.saturday:
        return localizations.saturady;
      case Weekday.sunday:
        return localizations.sunday;
    }
  }
}

extension StatusTimeExtension on List<MensaOpeningDetails> {
  Status get status {
    final todaysHours = _getTodayOpeningDetails();
    if (todaysHours == null) return Status.closed;

    final now = DateTime.now();
    final startTime = _parseTime(todaysHours.startTime, now);
    final endTime = _parseTime(todaysHours.endTime, now);
    final closingSoonThreshold = endTime.subtract(const Duration(minutes: 30));
    if (now.isBefore(startTime)) {
      return Status.openingSoon;
    } else if (now.isAfter(startTime) && now.isBefore(closingSoonThreshold)) {
      return Status.open;
    } else if (now.isAfter(closingSoonThreshold) && now.isBefore(endTime)) {
      return Status.closingSoon;
    } else {
      return Status.closed;
    }
  }

  MensaOpeningDetails? _getTodayOpeningDetails() {
    final now = DateTime.now();
    return firstWhereOrNull((element) => Weekday.values.indexOf(element.day) == now.weekday);
  }

  String get closingTime {
    final todaysHours = _getTodayOpeningDetails();

    if (todaysHours == null) return "";

    final endTime = _parseTime(todaysHours.endTime, DateTime.now());
    return "${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}";
  }

  String get openingTime {
    final todaysHours = _getTodayOpeningDetails();
    if (todaysHours == null) return "";

    final startTime = _parseTime(todaysHours.startTime, DateTime.now());
    return "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}";
  }

  DateTime _parseTime(String time, DateTime referenceDate) {
    final parts = time.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(referenceDate.year, referenceDate.month, referenceDate.day, hour, minute);
  }
}

extension CurrentStatusExtension on MensaModel {
  Status get currentOpeningStatus => _determineCurrentStatus(openingHours.openingHours);

  Status get currentServingStatus => _determineCurrentStatus(openingHours.servingHours);

  Status _determineCurrentStatus(List<MensaOpeningDetails>? details) {
    if (status.isClosed) {
      return Status.closed;
    } else if (status.isTemporaryClosed) {
      return Status.temporarilyClosed;
    }
    return details?.status ?? Status.closed;
  }
}

extension StatusStylingExtension on Status {
  ({Color color, String text}) openingStatusShort(
    BuildContext context, {
    required List<MensaOpeningDetails> openingDetails,
  }) {
    final colors = context.colors;
    final localizations = context.locals.canteen;

    switch (this) {
      case Status.open:
        return (
          color: colors.successColors.textColors.strongColors.base,
          text: localizations.openUntil(openingDetails.closingTime)
        );
      case Status.closed:
        return (
          color: colors.neutralColors.textColors.mediumColors.base,
          text: localizations.closed,
        );
      case Status.openingSoon:
        return (
          color: colors.neutralColors.textColors.mediumColors.base,
          text: localizations.openingSoon(openingDetails.openingTime),
        );
      case Status.closingSoon:
        return (
          color: colors.warningColors.textColors.strongColors.base,
          text: localizations.openUntil(openingDetails.closingTime),
        );
      case Status.temporarilyClosed:
        return (
          color: colors.dangerColors.textColors.strongColors.base,
          text: localizations.temporaryClosed,
        );
    }
  }

  ({Color color, String text}) openingStatus(
    BuildContext context, {
    required List<MensaOpeningDetails> openingDetails,
  }) {
    final colors = context.colors;
    final localizations = context.locals.canteen;

    switch (this) {
      case Status.open:
        return (
          color: colors.successColors.textColors.strongColors.base,
          text: localizations.openDetails(openingDetails.openingTime, openingDetails.closingTime),
        );
      case Status.closed:
        return (
          color: colors.neutralColors.textColors.mediumColors.base,
          text: localizations.closed,
        );
      case Status.openingSoon:
        return (
          color: colors.neutralColors.textColors.mediumColors.base,
          text: localizations.openingSoon(openingDetails.openingTime),
        );
      case Status.closingSoon:
        return (
          color: colors.warningColors.textColors.strongColors.base,
          text: localizations.openUntil(openingDetails.closingTime),
        );
      case Status.temporarilyClosed:
        return (
          color: colors.dangerColors.textColors.strongColors.base,
          text: localizations.temporaryClosed,
        );
    }
  }

  ({Color color, String text}) servingStatus(
    BuildContext context, {
    required List<MensaOpeningDetails> openingDetails,
  }) {
    final colors = context.colors;
    final localizations = context.locals.canteen;

    switch (this) {
      case Status.open:
        return (
          color: colors.successColors.textColors.strongColors.base,
          text: localizations.servingOpenDetails(openingDetails.openingTime, openingDetails.closingTime),
        );
      case Status.closed:
        return (
          color: colors.neutralColors.textColors.mediumColors.base,
          text: localizations.servingClosed,
        );
      case Status.openingSoon:
        return (
          color: colors.neutralColors.textColors.mediumColors.base,
          text: localizations.servingOpeningSoon(openingDetails.openingTime),
        );
      case Status.closingSoon:
        return (
          color: colors.warningColors.textColors.strongColors.base,
          text: localizations.servingOpenUntil(openingDetails.closingTime),
        );
      case Status.temporarilyClosed:
        return (
          color: colors.dangerColors.textColors.strongColors.base,
          text: localizations.temporaryClosed,
        );
    }
  }
}
