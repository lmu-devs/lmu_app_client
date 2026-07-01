import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

class ClubsSuggestionTile extends StatelessWidget {
  const ClubsSuggestionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuTileHeadline.base(title: context.locals.clubs.addClub),
        LmuContentTile(
          content: LmuListItem.base(
            title: context.locals.clubs.suggestNewClub,
            mainContentAlignment: MainContentAlignment.center,
            leadingArea: const LeadingFancyIcons(icon: LucideIcons.plus),
            onTap: () => GetIt.I.get<FeedbackApi>().showFeedback(
                  context,
                  args: FeedbackArgs(
                    title: context.locals.clubs.addClub,
                    description: context.locals.clubs.suggestNewClubDescription,
                    inputHint: context.locals.clubs.suggestionInputHint,
                    type: FeedbackType.suggestion,
                    origin: 'ClubsScreen',
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
