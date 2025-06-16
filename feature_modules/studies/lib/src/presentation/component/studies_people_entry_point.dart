import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudiesPeopleEntryPoint extends StatelessWidget {
  const StudiesPeopleEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuContentTile(
          content: LmuListItem.action(
            actionType: LmuListItemAction.chevron,
            title: "People",
            leadingArea: const LmuInListBlurEmoji(emoji: "👥"),
            //onTap: () => const PeopleMainRoute().go(context),
            onTap: () => context.go('/studies/people'),
          ),
        ),
      ],
    );
  }
}
