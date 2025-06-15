import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class PeopleSuggestionTile extends StatelessWidget {
  const PeopleSuggestionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuTileHeadline.base(title: context.locals.feedback.missingItemInput),
        LmuContentTile(
          content: LmuListItem.base(
            title: context.locals.peoples.peopleSuggestion,
            mainContentAlignment: MainContentAlignment.center,
            leadingArea: const LeadingFancyIcons(icon: LucideIcons.megaphone),
            onTap: () {
              // GetIt.I.get<FeedbackApi>().showFeedback(context, type: FeedbackType.suggestion, origin: 'PeopleScreen');
            },
          ),
        ),
      ],
    );
  }
}
