import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:feedback/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../util/feedback_types.dart';
import '../util/send_feedback.dart';

class FeedbackModal extends StatefulWidget {
  const FeedbackModal({
    super.key,
    required this.feedbackOrigin,
  });

  final String feedbackOrigin;

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  late final TextEditingController _textController;
  late final ValueNotifier<String?> _feedbackNotifier;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _feedbackNotifier = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    _textController.dispose();
    _feedbackNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.feedback;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: localizations.feedbackTitle,
        leadingAction: LeadingAction.close,
        largeTitleTrailingWidgetAlignment: MainAxisAlignment.center,
      ),
      isBottomSheet: true,
      customScrollController: context.modalScrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          sliver: SliverStack(
            children: [
              SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: false,
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
                      feedbackNotifier: _feedbackNotifier,
                      onFeedbackSelected: (feedback) {
                        _feedbackNotifier.value = feedback;
                      },
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                    LmuInputField(
                      hintText: localizations.feedbackInputHint,
                      isMultiline: true,
                      controller: _textController,
                      isAutocorrect: true,
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                ),
              ),
              SliverPositioned(
                bottom: LmuSizes.size_16,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: ValueListenableBuilder<String?>(
                    valueListenable: _feedbackNotifier,
                    builder: (context, selectedFeedback, _) {
                      return LmuButton(
                        title: localizations.feedbackButton,
                        size: ButtonSize.large,
                        showFullWidth: true,
                        state: selectedFeedback == null
                            ? ButtonState.disabled
                            : _isLoading
                                ? ButtonState.loading
                                : ButtonState.enabled,
                        onTap: selectedFeedback == null
                            ? null
                            : () async {
                                setState(() => _isLoading = true);
                                await sendFeedback(
                                  context: context,
                                  type: FeedbackType.general,
                                  rating: selectedFeedback,
                                  message: _textController.text.isEmpty ? null : _textController.text,
                                  screen: widget.feedbackOrigin,
                                  tags: null,
                                ).then((_) async {
                                  Navigator.of(context).pop();
                                  setState(() => _isLoading = false);
                                  if (selectedFeedback == EmojiFeedback.good.name.toUpperCase()) {
                                    AppReviewUtil.askForAppReview();
                                  }
                                });
                              },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
