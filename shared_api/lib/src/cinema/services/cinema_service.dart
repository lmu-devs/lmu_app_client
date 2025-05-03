import 'package:flutter/material.dart';

import '../../../explore.dart';

abstract class CinemaService {
  Widget get cinemaPage;
  Stream<List<ExploreLocation>> get cinemaExploreLocationsStream;

  void navigateToCinemaPage(BuildContext context);

  List<Widget> cinemaMapContentBuilder(BuildContext context, String cinemaId, ScrollController controller);
}
