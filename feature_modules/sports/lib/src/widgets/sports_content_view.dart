import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';

import '../repository/api/models/sports_model.dart';
import 'sports_grouped_course_section.dart';
import 'sports_info_section.dart';

class SportsContentView extends StatelessWidget {
  const SportsContentView({super.key, required this.sports});

  final List<SportsModel> sports;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SportsInfoSection(sports: sports),
          //const SportsFilterSection(),
          const SportsGroupedCourseSection(),
          const SizedBox(height: LmuSizes.size_96)
        ],
      ),
    );
  }
}
