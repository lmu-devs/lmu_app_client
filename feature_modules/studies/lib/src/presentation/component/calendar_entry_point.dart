import 'package:core/components.dart';
import 'package:core_routes/calendar.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';

class CalanderEntryPoint extends StatelessWidget {
  const CalanderEntryPoint.CalanderEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final isCalendarActive = GetIt.I.get<FeatureToggleApi>().isEnabled('CALENDAR');
    if (!isCalendarActive) {
      return const SizedBox.shrink();
    }
    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: "Calendar",
        leadingArea: const LmuInListBlurEmoji(emoji: "📅"),
        onTap: () => const CalendarMainRoute().go(context),
      ),
    );
  }
}
