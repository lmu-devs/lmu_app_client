import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/courses.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../application/usecase/get_faculties_usecase.dart';

class CoursesEntryPoint extends StatelessWidget {
  const CoursesEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFaculties =
        GetIt.I.get<GetFacultiesUsecase>().selectedFaculties;

    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: context.locals.courses.coursesTitle,
        leadingArea: const LmuInListBlurEmoji(emoji: "🧑‍🏫"),
        onTap: () {
          if (selectedFaculties.length == 1) {
            CoursesOverviewRoute(facultyId: selectedFaculties.first.id).go(context);
          } else {
            const CoursesFacultyOverviewRoute().go(context);
          }
        },
      ),
    );
  }
}
