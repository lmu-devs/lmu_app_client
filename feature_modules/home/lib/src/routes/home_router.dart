import 'package:core_routes/home.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';

class HomeRouterImpl extends HomeRouter {
  @override
  Widget buildMain(BuildContext context) => const HomePage();

  @override
  Widget buildLinks(BuildContext context) => const LinksPage();

  @override
  Widget buildLinksSearch(BuildContext context) => const LinksSearchPage();

  @override
  Widget buildBenefits(BuildContext context) => const BenefitsPage();
}
