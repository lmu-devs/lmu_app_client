import 'package:core/components.dart';
import 'package:core_routes/grades.dart';
import 'package:flutter/material.dart';

class GradesEntryPoint extends StatelessWidget {
  const GradesEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: "Dein Schnitt",
        subtitle: "13 Noten",
        trailingTitle: "Ø 1,3",
        onTap: () {
          const GradesMainRoute().go(context);
        },
      ),
    );
  }
}
