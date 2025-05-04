import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          ...benefits.map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(bottom: LmuSizes.size_12),
              child: BenefitsCard(benefit: benefit),
            ),
          ),
          const SizedBox(height: LmuSizes.size_16),
          LmuTileHeadline.base(title: context.locals.feedback.missingItemInput),
          LmuContentTile(
            content: LmuListItem.base(
              title: context.locals.home.benefitSuggestion,
              mainContentAlignment: MainContentAlignment.center,
              leadingArea: const LeadingFancyIcons(icon: LucideIcons.megaphone),
              onTap: () {
                GetIt.I.get<FeedbackApi>().showFeedback(
                      context,
                      type: FeedbackType.suggestion,
                      origin: 'BenefitsScreen',
                    );
              },
            ),
          ),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }
}
