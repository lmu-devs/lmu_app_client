import 'package:core/components.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class PeopleEntryPoint extends StatelessWidget {
  const PeopleEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final isPeopleActive = GetIt.I.get<FeatureToggleService>().isEnabled('PEOPLE');
    if (!isPeopleActive) {
      return const SizedBox.shrink();
    }
    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: context.locals.people.peopleTitle,
        leadingArea: const LmuInListBlurEmoji(emoji: "👥"),
        onTap: () => const PeopleMainRoute().go(context),
      ),
    );
  }
}
