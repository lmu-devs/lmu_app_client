import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:feedback/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BugModal extends StatefulWidget {
  const BugModal({
    super.key,
    required this.feedbackOrigin,
  });

  final String feedbackOrigin;

  @override
  State<BugModal> createState() => _BugModalState();
}

class _BugModalState extends State<BugModal> {
  late final TextEditingController _textController;
  late final ValueNotifier<bool> _textNotifier;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _textNotifier = ValueNotifier<bool>(false);

    _textController.addListener(_onTextControllerValue);
  }

  @override
  void dispose() {
    _textController.dispose();
    _textNotifier.dispose();

    super.dispose();
  }

  void _onTextControllerValue() {
    _textNotifier.value = _textController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.feedback;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: localizations.bugTitle,
        leadingAction: LeadingAction.close,
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
                  children: [
                    const SizedBox(height: LmuSizes.size_4),
                    LmuText.body(
                      localizations.bugDescription,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                    ),
                    const SizedBox(height: LmuSizes.size_32),
                    LmuInputField(
                      hintText: localizations.bugInputHint,
                      controller: _textController,
                      isAutofocus: true,
                      isMultiline: true,
                      isAutocorrect: true,
                    ),
                  ],
                ),
              ),
              SliverPositioned(
                bottom: LmuSizes.size_16,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _textNotifier,
                    builder: (context, isTextNotEmpty, _) {
                      return LmuButton(
                        title: localizations.bugButton,
                        size: ButtonSize.large,
                        showFullWidth: true,
                        state: isTextNotEmpty
                            ? _isLoading
                                ? ButtonState.loading
                                : ButtonState.enabled
                            : ButtonState.disabled,
                        onTap: isTextNotEmpty
                            ? () async {
                                setState(() => _isLoading = true);
                                await sendFeedback(
                                  context: context,
                                  type: FeedbackType.bug,
                                  rating: null,
                                  message: _textController.text,
                                  screen: widget.feedbackOrigin,
                                  tags: null,
                                ).then((_) {
                                  Navigator.of(context).pop();
                                  setState(() => _isLoading = false);
                                });
                              }
                            : null,
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
