import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';

import '../../application/usecase/get_faculties_usecase.dart';

class PeopleEntryPoint extends StatelessWidget {
  const PeopleEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final isPeopleActive = GetIt.I.get<FeatureToggleApi>().isEnabled('PEOPLE');
    if (!isPeopleActive) {
      return const SizedBox.shrink();
    }

    final selectedFaculties = GetIt.I.get<GetFacultiesUsecase>().selectedFaculties;

    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: context.locals.people.peopleTitle,
        leadingArea: const LmuInListBlurEmoji(emoji: "👥"),
        onTap: () {
          if (selectedFaculties.length == 1) {
            PeopleOverviewRoute(facultyId: selectedFaculties.first.id).go(context);
          } else {
            const PeopleFacultyOverviewRoute().go(context);
          }
        },
      ),
    );
  }
}
