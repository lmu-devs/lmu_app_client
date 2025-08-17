import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/model/helper/date_time_formatter.dart';

enum CalendarLabelType {
  day,
  emptyRange,
  month,
  year,
}

class CalendarDateInfoLabel extends StatelessWidget {
  const CalendarDateInfoLabel.day({
    super.key,
    required this.date,
    this.isToday = false,
  })  : type = CalendarLabelType.day,
        lastDate = null,
        currentDate = null,
        appendYear = false;

  const CalendarDateInfoLabel.emptyRange({
    super.key,
    required this.lastDate,
    required this.currentDate,
  })  : type = CalendarLabelType.emptyRange,
        date = null,
        isToday = false,
        appendYear = false;

  const CalendarDateInfoLabel.month({
    super.key,
    required this.date,
    this.appendYear = false,
  })  : type = CalendarLabelType.month,
        isToday = false,
        lastDate = null,
        currentDate = null;

  const CalendarDateInfoLabel.year({
    super.key,
    required this.date,
  })  : type = CalendarLabelType.year,
        isToday = false,
        lastDate = null,
        currentDate = null,
        appendYear = false;

  final CalendarLabelType type;
  final DateTime? date;
  final DateTime? lastDate;
  final DateTime? currentDate;
  final bool isToday;
  final bool appendYear;

  static const leftSpacing = LmuSizes.size_24;
  static const gapSpacing = LmuSizes.size_12;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CalendarLabelType.day:
        return _buildDayLabel(context);
      case CalendarLabelType.emptyRange:
        return _buildEmptyRangeLabel(context);
      case CalendarLabelType.month:
        return _buildMonthLabel(context);
      case CalendarLabelType.year:
        return _buildYearLabel(context);
    }
  }

  Widget _buildDayLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: leftSpacing, bottom: gapSpacing, top: gapSpacing),
      child: LmuText.body(
        DateTimeFormatter.formatShortDateRelative(date!),
        color: isToday
            ? context.colors.brandColors.textColors.strongColors.active
            : context.colors.neutralColors.textColors.strongColors.pressed,
        weight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmptyRangeLabel(BuildContext context) {
    final weakBaseColor = context.colors.neutralColors.textColors.weakColors.base;
    final start = lastDate!.add(const Duration(days: 1));
    final end = currentDate!.subtract(const Duration(days: 1));

    if (start.isAfter(end)) return const SizedBox.shrink();

    final daysInBetweenLabel = start.isSameDay(end)
        ? DateTimeFormatter.formatDayMonth(start)
        : '${DateTimeFormatter.formatDayMonth(start)} - ${DateTimeFormatter.formatDayMonth(end)}';

    return Padding(
      padding: const EdgeInsets.only(top: gapSpacing * 2, bottom: gapSpacing),
      child: LmuText.bodySmall(
        daysInBetweenLabel,
        textAlign: TextAlign.center,
        color: weakBaseColor,
      ),
    );
  }

  Widget _buildMonthLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: leftSpacing, top: gapSpacing),
      child: LmuText.h1(
        DateTimeFormatter.formatMonthName(date!, withYearIfDifferent: true),
        color: context.colors.neutralColors.textColors.weakColors.base,
      ),
    );
  }

  Widget _buildYearLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: leftSpacing, bottom: gapSpacing * 4, top: gapSpacing * 4),
      child: LmuText.h0(
        '${date!.year}',
        color: context.colors.neutralColors.textColors.weakColors.base.withAlpha(50),
        textAlign: TextAlign.center,
      ),
    );
  }
}
