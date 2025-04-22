import 'package:flutter/material.dart';

import '../../../explore.dart';

abstract class MensaService {
  Stream<List<ExploreLocation>> get mensaExploreLocationsStream;

  void navigateToMensaPage(BuildContext context);

  List<Widget> mensaMapContentBuilder(BuildContext context, String mensaId, ScrollController controller);
}
