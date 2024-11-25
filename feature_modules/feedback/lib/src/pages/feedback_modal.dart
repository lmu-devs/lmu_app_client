import 'package:flutter/material.dart';

import 'package:core/themes.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:feedback/src/widgets/widgets.dart';

class FeedbackModal extends StatelessWidget {
  const FeedbackModal({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.feedback;
    final textController = TextEditingController();
    final feedbackNotifier = ValueNotifier<String?>(null);

    return LmuScaffoldWithAppBar(
      largeTitle: localizations.feedbackTitle,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.center,
      stretch: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.mediumLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: LmuSizes.small),
                  LmuText.body(
                    localizations.feedbackDescription,
                    color: context
                        .colors.neutralColors.textColors.mediumColors.base,
                  ),
                  const SizedBox(height: LmuSizes.xxxlarge),
                  EmojiFeedbackSelector(
                    feedbackNotifier: feedbackNotifier,
                    onFeedbackSelected: (feedback) {
                      print(feedback);
                    },
                  ),
                  const SizedBox(height: LmuSizes.xlarge),
                  LmuInputField(
                    hintText: localizations.feedbackInputHint,
                    isMultiline: true,
                    controller: textController,
                    isAutocorrect: true,
                    onSubmitted: (value) {
                      print(value);
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
                child: ValueListenableBuilder<String?>(
                  valueListenable: feedbackNotifier,
                  builder: (context, selectedFeedback, _) {
                    return LmuButton(
                      title: localizations.feedbackButton,
                      size: ButtonSize.large,
                      showFullWidth: true,
                      state: selectedFeedback == null ? ButtonState.disabled : ButtonState.enabled,
                      onTap: selectedFeedback == null ? null : () {
                        // TODO: send data to backend with selectedFeedback and textController.text
                        Navigator.pop(context);
                        LmuToast.show(
                          context: context,
                          message: localizations.feedbackSuccess,
                          type: ToastType.success,
                        );
                      },
                    );
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
