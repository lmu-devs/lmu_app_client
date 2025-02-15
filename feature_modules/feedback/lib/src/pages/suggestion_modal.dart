import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../util/feedback_types.dart';
import '../util/send_feedback.dart';

class SuggestionModal extends StatelessWidget {
  const SuggestionModal({
    super.key,
    required this.feedbackOrigin,
  });

  final String feedbackOrigin;

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.feedback;
    final textController = TextEditingController();
    final textNotifier = ValueNotifier<bool>(false);

    textController.addListener(() {
      textNotifier.value = textController.text.isNotEmpty;
    });

    return LmuMasterAppBar.bottomSheet(
      largeTitle: localizations.suggestionTitle,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.size_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: LmuSizes.size_4),
                  LmuText.body(
                    localizations.suggestionDescription,
                    color: context.colors.neutralColors.textColors.mediumColors.base,
                  ),
                  const SizedBox(height: LmuSizes.size_32),
                  LmuInputField(
                    hintText: localizations.suggestionInputHint,
                    controller: textController,
                    isAutofocus: true,
                    isMultiline: true,
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
                child: ValueListenableBuilder<bool>(
                  valueListenable: textNotifier,
                  builder: (context, isTextNotEmpty, _) {
                    return LmuButton(
                      title: localizations.suggestionButton,
                      size: ButtonSize.large,
                      showFullWidth: true,
                      state: isTextNotEmpty ? ButtonState.enabled : ButtonState.disabled,
                      onTap: isTextNotEmpty
                          ? () => sendFeedback(
                                context: context,
                                type: FeedbackType.suggestion,
                                rating: null,
                                message: textController.text,
                                screen: feedbackOrigin,
                                tags: null,
                              )
                          : null,
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
