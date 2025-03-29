import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../repository/api/models/sports_model.dart';
import 'sports_all_course_section.dart';
import 'sports_button_section.dart';
import 'sports_info_section.dart';
import 'widgets.dart';

class SportsContentView extends StatelessWidget {
  const SportsContentView({super.key, required this.sports});

  final SportsModel sports;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SportsInfoSection(sports: sports),
          SportsFavoritesCourseSection(sportsTypes: sports.sportTypes),
          const SportsButtonSection(),
          SportsAllCourseSection(sportsTypes: sports.sportTypes),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }
}
