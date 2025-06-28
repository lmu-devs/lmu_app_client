import 'package:core_routes/benefits.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/models/benefit_category.dart';
import '../../../presentation/view/benefits_details_page.dart';
import '../../../presentation/view/benefits_page.dart';

class BenefitsRouterImpl extends BenefitsRouter {
  @override
  Widget buildMain(BuildContext context) => BenefitsPage();

  @override
  Widget buildDetails(BuildContext context, {required RBenefitCategory? category}) => BenefitsDetailsPage(
        category: category as BenefitCategory?,
      );
}
