import 'package:core_routes/mensa.dart';
import 'package:flutter/material.dart';

import '../pages/mensa_details_page.dart';
import '../pages/mensa_page.dart';
import '../pages/mensa_search_page.dart';
import '../repository/repository.dart';

class MensaRouterImpl extends MensaRouter {
  @override
  Widget buildMain(BuildContext context) => const MensaPage();

  @override
  Widget buildDetails(BuildContext context, RMensaModel mensaModel) =>
      MensaDetailsPage(mensaModel: mensaModel as MensaModel);

  @override
  Widget buildSearch(BuildContext context) => const MensaSearchPage();
}
