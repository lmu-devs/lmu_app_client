import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../explore.dart';

abstract class CinemaService {
  Widget get cinemaPage;
  RouteBase get cinemaData;
  Widget get movieTeaserList;
  Stream<List<ExploreLocation>> get cinemaExploreLocationsStream;

  void navigateToCinemaPage(BuildContext context);
}
