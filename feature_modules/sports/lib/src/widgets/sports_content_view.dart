import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../repository/api/models/sports_model.dart';
import 'sports_all_course_section.dart';
import 'sports_button_section.dart';
import 'widgets.dart';

class SportsContentView extends StatelessWidget {
  const SportsContentView({super.key, required this.sports});

  final SportsModel sports;

  int get _courseNumber => sports.sportTypes
      .map((element) => element.courses.length)
      .fold(0, (previousValue, currentValue) => previousValue + currentValue);

  @override
  Widget build(BuildContext context) {
    final sportsLocals = context.locals.sports;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: LmuSizes.size_16),
            child: LmuText(
              "${sports.sportTypes.length} ${sportsLocals.sportTypes}, $_courseNumber ${sportsLocals.courses}",
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
          ),
          SportsFavoritesCourseSection(sportsTypes: sports.sportTypes),
          const SportsButtonSection(),
          SportsAllCourseSection(sportsTypes: sports.sportTypes),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }
}
