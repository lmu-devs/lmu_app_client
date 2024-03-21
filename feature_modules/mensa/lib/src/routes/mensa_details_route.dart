import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

import '../pages/mensa_details_page.dart';

class MensaDetailsRoute extends StatelessWidget {
  const MensaDetailsRoute({
    required this.arguments,
    super.key,
  });

  final MensaRouteArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return const MensaDetailsPage();
  }
}
