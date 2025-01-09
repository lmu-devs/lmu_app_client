import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:feedback/src/util/feedback_types.dart';
import 'package:feedback/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../util/send_feedback.dart';

class FeedbackModal extends StatelessWidget {
  const FeedbackModal({
    super.key,
    required this.feedbackOrigin,
  });

  final String feedbackOrigin;

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.feedback;
    final textController = TextEditingController();
    final feedbackNotifier = ValueNotifier<String?>(null);

    return LmuMasterAppBar.bottomSheet(
      largeTitle: localizations.feedbackTitle,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.center,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            controller: ModalScrollController.of(context),
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.size_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: LmuSizes.size_4),
                  LmuText.body(
                    localizations.feedbackDescription,
                    color: context.colors.neutralColors.textColors.mediumColors.base,
                  ),
                  const SizedBox(height: LmuSizes.size_48),
                  EmojiFeedbackSelector(
                    feedbackNotifier: feedbackNotifier,
                    onFeedbackSelected: (feedback) {
                      feedbackNotifier.value = feedback;
                    },
                  ),
                  const SizedBox(height: LmuSizes.size_24),
                  LmuInputField(
                    hintText: localizations.feedbackInputHint,
                    isMultiline: true,
                    controller: textController,
                    isAutocorrect: true,
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
                padding: const EdgeInsets.all(LmuSizes.size_12),
                child: ValueListenableBuilder<String?>(
                  valueListenable: feedbackNotifier,
                  builder: (context, selectedFeedback, _) {
                    return LmuButton(
                      title: localizations.feedbackButton,
                      size: ButtonSize.large,
                      showFullWidth: true,
                      state: selectedFeedback == null ? ButtonState.disabled : ButtonState.enabled,
                      onTap: selectedFeedback == null
                          ? null
                          : () => sendFeedback(
                                context: context,
                                type: FeedbackType.general,
                                rating: selectedFeedback,
                                message: textController.text.isEmpty ? null : textController.text,
                                screen: feedbackOrigin,
                                tags: null,
                              ),
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
