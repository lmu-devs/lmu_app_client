import 'package:core/components.dart';
import 'package:core/constants.dart';

import 'package:core/themes.dart';
import 'package:feedback/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FeedbackModal extends StatelessWidget {
  const FeedbackModal({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffoldWithAppBar(
      largeTitle: 'Feedback',
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.center,
      body: Column(
        children: [
          const SizedBox(height: LmuSizes.small),
          LmuText.body(
            'How\'s your experience with the app?',
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
          const SizedBox(height: LmuSizes.xxxlarge),
          EmojiFeedbackSelector(
            onFeedbackSelected: (feedback) {
              print(feedback);
            },
          ),
        ],
      ),
    );
  }
}
