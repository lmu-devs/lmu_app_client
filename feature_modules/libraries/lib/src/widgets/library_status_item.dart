import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/localizations.dart';

import '../repository/api/api.dart';

LmuListItem buildLibraryStatusItem({
  required MapEntry<int, OpeningDayModel> entry,
  required AppLocalizations appLocalizations,
}) {
  final index = entry.key;
  final day = entry.value;
  final isToday = DateTime.now().weekday - 1 == index;

  final times = day.timeframes.map((tf) {
    final start = tf.start.substring(0, 5);
    final end = tf.end.substring(0, 5);
    return '$start - $end';
  }).join(', ');

  return LmuListItem.base(
    title: isToday ? day.day.localizedWeekday(appLocalizations) : null,
    subtitle: !isToday ? day.day.localizedWeekday(appLocalizations) : null,
    trailingTitle: isToday ? times : null,
    trailingSubtitle: !isToday ? times : null,
    hasHorizontalPadding: false,
    hasVerticalPadding: false,
  );
}
