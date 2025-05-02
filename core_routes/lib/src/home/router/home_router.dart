import 'package:flutter/material.dart';

abstract class HomeRouter {
  Widget buildMain(BuildContext context);

  Widget buildLinks(BuildContext context);

  Widget buildLinksSearch(BuildContext context);

  Widget buildBenefits(BuildContext context);
}
