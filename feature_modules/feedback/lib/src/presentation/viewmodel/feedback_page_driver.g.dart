// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.3"

class _$TestFeedbackPageDriver extends TestDriver implements FeedbackPageDriver {
  @override
  String get largeTitle => ' ';

  @override
  String get description => ' ';

  @override
  String get inputHint => ' ';

  @override
  TextEditingController get textEditingController => const _TestTextEditingController();

  @override
  bool get showEmojiPicker => false;

  @override
  String get buttonTitle => ' ';

  @override
  ButtonState get buttonState => ButtonState.values[0];

  @override
  void onEmojiSelected(EmojiFeedback feedback) {}

  @override
  Future<void> onSendFeedbackButtonTap() {
    return Future.value();
  }

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $FeedbackPageDriverProvider extends WidgetDriverProvider<FeedbackPageDriver> {
  @override
  FeedbackPageDriver buildDriver() {
    return FeedbackPageDriver();
  }

  @override
  FeedbackPageDriver buildTestDriver() {
    return _$TestFeedbackPageDriver();
  }
}
