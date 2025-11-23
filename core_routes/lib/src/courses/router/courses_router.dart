import 'package:flutter/widgets.dart';

import '../models/person_details_data.dart';

abstract class CoursesRouter {
  Widget buildOverview(BuildContext context, {required int facultyId});

  Widget buildFacultyOverview(BuildContext context);

  Widget buildDetails(
    BuildContext context, {
    required int facultyId,
    required int courseId,
    required String name,
    required String language,
    String? degree,
    int? sws,
  });

  Widget buildPersonsDetails(BuildContext context, RPersonDetailsData $extra);

  Widget buildContentDetails(
    BuildContext context, {
    required int facultyId,
    required int courseId,
    required String name,
    required String language,
    required String content,
    String? degree,
    int? sws,
  });

  Widget buildSearch(BuildContext context, {required int facultyId});
}
