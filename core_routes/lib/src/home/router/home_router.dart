import 'package:flutter/material.dart';

abstract class HomeRouter {
  Widget buildMain(BuildContext context);

  Widget buildLinks(BuildContext context);

  Widget buildLinksFaculties(BuildContext context);

  Widget buildLinksOverview(BuildContext context, {required int facultyId});

  Widget buildLinksSearch(BuildContext context, {required int facultyId});
}
