import 'package:flutter/material.dart';

abstract class ExploreRouter {
  Widget buildMain(BuildContext context, {String? filter});

  Widget buildSearch(BuildContext context);
}
