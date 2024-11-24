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
      stretch: false,

      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  const SizedBox(height: 400),

                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(LmuSizes.medium),
                child: LmuButton(
                  title: 'Submit Feedback',
                  size: ButtonSize.large,
                  showFullWidth: true,
                  onTap: () {
                    // Add your button action here
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
