import 'package:collection/collection.dart';
import 'package:core/api.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';

import '../repository/api/models/models.dart';

enum Status {
  openingSoon,
  open,
  pause,
  closingSoon,
  closed,
}

extension LibraryOpeningStatusExtension on List<OpeningDayModel> {
  Status get status {
    final today = _todayOpening;
    if (today == null || today.timeframes.isEmpty) return Status.closed;

    final now = DateTime.now();
    final timeframes = today.timeframes
        .map((tf) => _parseTimeframe(tf, now))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    for (final tf in timeframes) {
      if (now.isBefore(tf.start)) return Status.openingSoon;
      if (now.isAfter(tf.start) && now.isBefore(tf.end.subtract(const Duration(minutes: 30)))) {
        return Status.open;
      }
      if (now.isAfter(tf.end.subtract(const Duration(minutes: 30))) && now.isBefore(tf.end)) {
        return Status.closingSoon;
      }
    }

    // Check for pause
    for (int i = 0; i < timeframes.length - 1; i++) {
      final tfCurrent = timeframes[i];
      final tfNext = timeframes[i + 1];
      if (now.isAfter(tfCurrent.end) && now.isBefore(tfNext.start)) {
        return Status.pause;
      }
    }

    return Status.closed;
  }

  OpeningDayModel? get _todayOpening {
    final now = DateTime.now();
    return firstWhereOrNull((e) => Weekday.values.indexOf(e.day) == now.weekday - 1);
  }

  String get openingTime {
    final tf = _todayOpening?.timeframes.firstOrNull;
    if (tf == null) return "";
    final dt = _parseTime(tf.start, DateTime.now());
    return _formatTime(dt);
  }

  String get closingTime {
    final tf = _todayOpening?.timeframes.lastOrNull;
    if (tf == null) return "";
    final dt = _parseTime(tf.end, DateTime.now());
    return _formatTime(dt);
  }

  DateTime _parseTime(String time, DateTime reference) {
    final parts = time.split(":");
    return DateTime(reference.year, reference.month, reference.day, int.parse(parts[0]), int.parse(parts[1]));
  }

  _Timeframe _parseTimeframe(TimeframeModel tf, DateTime ref) =>
      _Timeframe(start: _parseTime(tf.start, ref), end: _parseTime(tf.end, ref));

  String _formatTime(DateTime dt) =>
      "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
}

class _Timeframe {
  final DateTime start;
  final DateTime end;
  _Timeframe({required this.start, required this.end});
}

extension AreaStatusExtension on AreaModel {
  Status get currentStatus =>
      openingHours?.days?.status ?? Status.closed;

  String get openingTime =>
      openingHours?.days?.openingTime ?? "";

  String get closingTime =>
      openingHours?.days?.closingTime ?? "";

  ({Color color, String text}) getStyledStatusShort(BuildContext context) {
    final localizations = context.locals.libraries;
    final colors = context.colors;

    switch (currentStatus) {
      case Status.open:
        return (
        color: colors.successColors.textColors.strongColors.base,
        text: localizations.openUntil(closingTime),
        );
      case Status.closingSoon:
        return (
        color: colors.warningColors.textColors.strongColors.base,
        text: localizations.openUntil(closingTime),
        );
      case Status.openingSoon:
        return (
        color: colors.neutralColors.textColors.mediumColors.base,
        text: localizations.openingSoon(openingTime),
        );
      case Status.pause:
        return (
        color: colors.neutralColors.textColors.mediumColors.base,
        text: localizations.onPause(openingTime),
        );
      case Status.closed:
        return (
        color: colors.neutralColors.textColors.mediumColors.base,
        text: localizations.closed,
        );
    }
  }

  ({Color color, String text}) getStyledStatus(BuildContext context) {
    final localizations = context.locals.libraries;
    final colors = context.colors;

    switch (currentStatus) {
      case Status.open:
        return (
        color: colors.successColors.textColors.strongColors.base,
        text: localizations.openNow,
        );
      case Status.closingSoon:
        return (
        color: colors.warningColors.textColors.strongColors.base,
        text: localizations.openUntil(closingTime),
        );
      case Status.openingSoon:
        return (
        color: colors.neutralColors.textColors.mediumColors.base,
        text: localizations.openingSoon(openingTime),
        );
      case Status.pause:
        return (
        color: colors.neutralColors.textColors.mediumColors.base,
        text: localizations.onPause(openingTime),
        );
      case Status.closed:
        return (
        color: colors.neutralColors.textColors.mediumColors.base,
        text: localizations.closed,
        );
    }
  }
}
