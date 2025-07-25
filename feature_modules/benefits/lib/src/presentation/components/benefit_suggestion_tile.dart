import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

class BenefitSuggestionTile extends StatelessWidget {
  const BenefitSuggestionTile({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = context.locals;
    final benefitLocals = locals.benefits;
    return Column(
      children: [
        LmuTileHeadline.base(title: locals.feedback.missingItemInput),
        LmuContentTile(
          content: LmuListItem.base(
            title: context.locals.benefits.benefitSuggestion,
            mainContentAlignment: MainContentAlignment.center,
            leadingArea: const LeadingFancyIcons(icon: LucideIcons.megaphone),
            onTap: () => GetIt.I.get<FeedbackApi>().showFeedback(
                  context,
                  args: FeedbackArgs(
                    title: benefitLocals.benefitSuggestion,
                    description: benefitLocals.benefitSuggestionDescription,
                    inputHint: benefitLocals.benefitSuggestionHint,
                    type: FeedbackType.suggestion,
                    origin: 'BenefitsScreen',
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
