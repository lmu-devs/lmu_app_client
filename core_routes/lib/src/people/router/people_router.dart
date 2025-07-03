import 'package:flutter/widgets.dart';
import 'package:shared_api/studies.dart';

abstract class PeopleRouter {
  Widget buildOverview(BuildContext context, {required Faculty? faculty});
  Widget buildFacultyOverview(BuildContext context);
}
