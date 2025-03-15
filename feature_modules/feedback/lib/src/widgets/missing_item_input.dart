import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

class MissingItemInput extends StatelessWidget {
  const MissingItemInput({
    super.key,
    required this.title,
    required this.feedbackOrigin,
  });

  final String title;
  final String feedbackOrigin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuTileHeadline.base(title: context.locals.feedback.missingItemInput),
        LmuContentTile(
          content: LmuListItem.base(
            title: title,
            mainContentAlignment: MainContentAlignment.center,
            leadingArea: const LeadingFancyIcons(icon: LucideIcons.megaphone),
            onTap: () {
              GetIt.I.get<FeedbackService>().navigateToSuggestion(context, feedbackOrigin);
            },
          ),
        ),
      ],
    );
  }
}
