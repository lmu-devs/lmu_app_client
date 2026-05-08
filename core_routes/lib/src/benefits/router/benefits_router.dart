import 'package:flutter/widgets.dart';

import '../models/router_benefit_category.dart';

abstract class BenefitsRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, {required RBenefitCategory? category});
}
