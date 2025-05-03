import 'package:flutter/material.dart';

import '../../../explore.dart';

abstract class CinemaService {
  Stream<List<ExploreLocation>> get cinemaExploreLocationsStream;

  List<Widget> cinemaMapContentBuilder(BuildContext context, String cinemaId, ScrollController controller);
}
