import 'package:core/components.dart';
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
        LmuTileHeadline.base(title: "Add club"),
        LmuContentTile(
          content: LmuListItem.base(
            title: "Suggest a new club",
            mainContentAlignment: MainContentAlignment.center,
            leadingArea: const LeadingFancyIcons(icon: LucideIcons.club),
            onTap: () => GetIt.I.get<FeedbackApi>().showFeedback(
                  context,
                  args: FeedbackArgs(
                    title: "Add club",
                    description: "Suggest a new club to be added",
                    inputHint: "Enter your suggestion",
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
