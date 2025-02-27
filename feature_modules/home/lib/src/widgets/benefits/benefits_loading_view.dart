import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import 'benefits_card_loading.dart';

class BenefitsLoadingView extends StatelessWidget {
  const BenefitsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: LmuSizes.size_16,
        right: LmuSizes.size_16,
        bottom: LmuSizes.size_96,
      ),
      child: Column(
        children: List.generate(4, (index) {
          return const Column(
            children: [
              BenefitsCardLoading(),
              SizedBox(height: 16),
            ],
          );
        }),
      ),
    );
  }
}
