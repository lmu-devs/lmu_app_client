import 'package:core_routes/home.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';

class HomeRouterImpl extends HomeRouter {
  @override
  Widget buildMain(BuildContext context) => const HomePage();

  @override
  Widget buildLinks(BuildContext context) => const LinksPage();

  @override
  Widget buildLinksFaculties(BuildContext context) => const LinksFacultiesPage();

  @override
  Widget buildLinksOverview(BuildContext context, {required int facultyId}) => LinksOverviewPage(facultyId: facultyId);

  @override
  Widget buildLinksSearch(BuildContext context, {required int facultyId}) => LinksSearchPage(facultyId: facultyId);
}
