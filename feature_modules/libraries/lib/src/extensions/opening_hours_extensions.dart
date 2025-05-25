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

extension LibraryOpeningStatusExtension on List<OpeningHoursModel> {
  Status get status {
    final today = _todayOpening;
    if (today == null || today.timeframes.isEmpty) return Status.closed;

    final now = DateTime.now();
    final timeframes = today.timeframes
        .map((tf) => _parseTimeframe(tf, now))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    for (final tf in timeframes) {
      if (now.isAfter(tf.start) && now.isBefore(tf.end.subtract(const Duration(minutes: 30)))) {
        return Status.open;
      }
      if (now.isAfter(tf.end.subtract(const Duration(minutes: 30))) && now.isBefore(tf.end)) {
        return Status.closingSoon;
      }
    }

    for (int i = 0; i < timeframes.length - 1; i++) {
      final tfCurrent = timeframes[i];
      final tfNext = timeframes[i + 1];
      if (now.isAfter(tfCurrent.end) && now.isBefore(tfNext.start)) {
        return Status.pause;
      }
    }

    if (now.isBefore(timeframes.first.start)) {
      return Status.openingSoon;
    }

    return Status.closed;
  }

  OpeningHoursModel? get _todayOpening {
    final now = DateTime.now();
    final todayWeekday = Weekday.values[now.weekday - 1];
    return firstWhereOrNull((e) => e.day == todayWeekday);
  }

  String get openingTime {
    final now = DateTime.now();
    final today = _todayOpening;
    if (today == null) return "";

    final timeframes = today.timeframes
        .map((tf) => _parseTimeframe(tf, now))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    switch (status) {
      case Status.open:
      case Status.closingSoon:
        final current = timeframes.firstWhereOrNull(
              (tf) => now.isAfter(tf.start) && now.isBefore(tf.end),
        );
        return current != null ? _formatTime(current.end) : "";
      case Status.pause:
      case Status.openingSoon:
        final next = timeframes.firstWhereOrNull(
              (tf) => now.isBefore(tf.start),
        );
        return next != null ? _formatTime(next.start) : "";
      case Status.closed:
        return "";
    }
  }

  String get closingTime {
    final now = DateTime.now();
    final today = _todayOpening;
    if (today == null) return "";

    final timeframes = today.timeframes
        .map((tf) => _parseTimeframe(tf, now))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    final current = timeframes.firstWhereOrNull(
          (tf) => now.isAfter(tf.start) && now.isBefore(tf.end),
    );

    return current != null ? _formatTime(current.end) : "";
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
      openingHours?.status ?? Status.closed;

  String get openingTime =>
      openingHours?.openingTime ?? "";

  String get closingTime =>
      openingHours?.closingTime ?? "";

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

extension LibraryOverallStatusExtension on LibraryModel {
  ({Color? color, String? text}) getDominantStyledStatus(BuildContext context) {
    if (areas.isEmpty) {
      return (color: null, text: null);
    }

    if (areas.length == 1) {
      return areas.first.getStyledStatus(context);
    }

    AreaModel? representativeArea;

    representativeArea = areas.firstWhereOrNull((area) => area.currentStatus == Status.open);
    if (representativeArea != null) {
      return representativeArea.getStyledStatus(context);
    }

    representativeArea = areas.firstWhereOrNull((area) => area.currentStatus == Status.pause);
    if (representativeArea != null) {
      return representativeArea.getStyledStatus(context);
    }

    representativeArea = areas.firstWhereOrNull((area) => area.currentStatus == Status.closingSoon);
    if (representativeArea != null) {
      return representativeArea.getStyledStatus(context);
    }

    representativeArea = areas.firstWhereOrNull((area) => area.currentStatus == Status.openingSoon);
    if (representativeArea != null) {
      return representativeArea.getStyledStatus(context);
    }

    return areas.first.getStyledStatus(context);
  }
}
