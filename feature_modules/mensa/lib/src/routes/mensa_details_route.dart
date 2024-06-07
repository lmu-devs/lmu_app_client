import 'package:core/routes.dart';
import 'package:flutter/widgets.dart';

import '../pages/mensa_details_page.dart';
import '../repository/api/api.dart';

class MensaDetailsRoute extends StatelessWidget {
  const MensaDetailsRoute({
    required this.arguments,
    super.key,
  });

  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    final mensaModel = (arguments as MensaDetailsRouteArguments).mensaModel as MensaModel;
    return MensaDetailsPage(
      mensaModel: mensaModel,
    );
  }
}
