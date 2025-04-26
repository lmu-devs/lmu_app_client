import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../favicon_fallback.dart';

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
              LmuCardLoading(
                hasSubtitle: true,
                subtitleLength: 3,
                leadingIcon: FaviconFallback(size: LmuIconSizes.mediumSmall),
                hasLargeImage: true,
                hasDivider: true,
              ),
            ],
          );
        }),
      ),
    );
  }
}
