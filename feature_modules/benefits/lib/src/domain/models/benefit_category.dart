import 'package:core_routes/benefits.dart';

import 'benefit.dart';

class BenefitCategory extends RBenefitCategory {
  const BenefitCategory({
    required this.title,
    required this.emoji,
    required this.benefits,
    this.description,
  });

  final String title;
  final String? description;
  final String emoji;
  final List<Benefit> benefits;
}
