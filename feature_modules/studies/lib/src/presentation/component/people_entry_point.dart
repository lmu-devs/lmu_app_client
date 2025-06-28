import 'package:core/components.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../application/usecase/get_faculties_usecase.dart'; // <-- Usecase importieren
import '../view/faculites_page.dart';

class PeopleEntryPoint extends StatelessWidget {
  const PeopleEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final isPeopleActive = GetIt.I.get<FeatureToggleService>().isEnabled('PEOPLE');
    if (!isPeopleActive) {
      return const SizedBox.shrink();
    }

    // Hole die aktuell ausgewählten Fakultäten aus dem Usecase!
    final selectedFaculties = GetIt.I.get<GetFacultiesUsecase>().selectedFaculties;

    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: context.locals.people.peopleTitle,
        leadingArea: const LmuInListBlurEmoji(emoji: "👥"),
        onTap: () {
          if (selectedFaculties.length == 1) {
            const PeopleMainRoute().go(context);
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FaculitesPage()),
            );
          }
        },
      ),
    );
  }
}
