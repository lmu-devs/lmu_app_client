import 'package:core/components.dart';
import 'package:core_routes/people.dart';
import 'package:flutter/material.dart';

class StudiesPeopleEntryPoint extends StatelessWidget {
  const StudiesPeopleEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuTileHeadline.base(title: "People"),
        LmuContentTile(
          content: LmuListItem.action(
            actionType: LmuListItemAction.chevron,
            title: "Find People",
            onTap: () => const PeopleMainRoute().go(context),
          ),
        ),
      ],
    );
  }
}
