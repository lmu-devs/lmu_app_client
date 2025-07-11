import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';

import '../repository/api/api.dart';

LmuListItem buildLibraryStatusItem({
  required OpeningHoursModel openingHours,
  required BuildContext context,
}) {
  final isToday = openingHours.day == Weekday.values[DateTime.now().weekday - 1];

  final timesColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: openingHours.timeframes.map((tf) {
      final start = tf.start.substring(0, 5);
      final end = tf.end.substring(0, 5);
      return LmuText.body(
        '$start - $end',
        textAlign: TextAlign.end,
        weight: isToday ? FontWeight.w600 : FontWeight.w400,
        color: isToday
            ? context.colors.neutralColors.textColors.strongColors.base
            : context.colors.neutralColors.textColors.mediumColors.base,
      );
    }).toList(),
  );

  return LmuListItem.base(
    title: isToday ? openingHours.day.name : null,
    subtitle: !isToday ? openingHours.day.name : null,
    trailingArea: timesColumn,
    hasHorizontalPadding: false,
    hasVerticalPadding: false,
    mainContentAlignment: MainContentAlignment.top,
  );
}
