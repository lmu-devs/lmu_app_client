import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../../repository/api/models/benefits/benefit_model.dart';
import 'benefits_card.dart';

class BenefitsContentView extends StatelessWidget {
  const BenefitsContentView({
    super.key,
    required this.benefits,
  });

  final List<BenefitModel> benefits;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: LmuSizes.size_16,
        right: LmuSizes.size_16,
        bottom: LmuSizes.size_96,
      ),
      child: Column(
        children: benefits.map((benefit) {
          return Column(
            children: [
              BenefitsCard(benefit: benefit),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}
