import 'package:flutter/material.dart';

import '../models/router_mensa_model.dart';

abstract class MensaRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, RMensaModel mensaModel);

  Widget buildSearch(BuildContext context);
}
