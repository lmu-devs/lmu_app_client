import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_api/feedback.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:widget_driver/widget_driver.dart';

import '../components/feedback_emoji_selector.dart';
import '../viewmodel/feedback_page_driver.dart';

class FeedbackPage extends DrivableWidget<FeedbackPageDriver> {
  FeedbackPage({super.key, required this.args});

  final FeedbackArgs args;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LmuScaffold(
      customScrollController: context.modalScrollController,
      isBottomSheet: true,
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.close,
        largeTitleTrailingWidgetAlignment: MainAxisAlignment.center,
      ),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
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
                      driver.description,
                      color: colors.neutralColors.textColors.mediumColors.base,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                    if (driver.showEmojiPicker) FeedbackEmojiSelector(onFeedbackSelected: driver.onEmojiSelected),
                    const SizedBox(height: LmuSizes.size_16),
                    LmuInputField(
                      hintText: driver.inputHint,
                      isMultiline: true,
                      controller: driver.textEditingController,
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
                  child: LmuButton(
                    title: driver.buttonTitle,
                    size: ButtonSize.large,
                    showFullWidth: true,
                    state: driver.buttonState,
                    onTap: driver.onSendFeedbackButtonTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<FeedbackPageDriver> get driverProvider => $FeedbackPageDriverProvider(args: args);
}
