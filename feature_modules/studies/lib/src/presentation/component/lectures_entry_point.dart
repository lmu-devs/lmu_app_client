import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/lectures.dart';
import 'package:flutter/widgets.dart';

class LecturesEntryPoint extends StatelessWidget {
  const LecturesEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: context.locals.lectures.lecturesTitle,
        leadingArea: const LmuInListBlurEmoji(emoji: "🧑🏼‍🏫"),
        onTap: () => const LecturesMainRoute().go(context),
      ),
    );
  }
}
