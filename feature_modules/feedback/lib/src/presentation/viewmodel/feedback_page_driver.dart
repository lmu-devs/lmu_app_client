import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecases/request_app_review_usecase.dart';
import '../../application/usecases/send_feedback_usecase.dart';
import '../../domain/models/emoji_feedback.dart';
import '../../domain/models/user_feedback.dart';

part 'feedback_page_driver.g.dart';

typedef FeedbackModalString = ({String title, String description, String inputHint});

@GenerateTestDriver()
class FeedbackPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  FeedbackPageDriver({
    @driverProvidableProperty required FeedbackArgs args,
  }) : _args = args;

  final _sendFeedbackUsecase = GetIt.I.get<SendFeedbackUsecase>();
  final _requestAppReviewUsecase = GetIt.I.get<RequestAppReviewUseCase>();

  late final TextEditingController _textEditingController;
  late final FeedbackArgs _args;

  late FeedbackLocalizations _localizations;
  late NavigatorState _navigatorState;
  late LmuToast _toast;

  bool _isLoading = false;
  EmojiFeedback? _selectedFeedback;

  FeedbackType get _type => _args.type;

  @TestDriverDefaultValue(_TestTextEditingController())
  TextEditingController get textEditingController => _textEditingController;

  String get largeTitle => _args.title ?? _type.title(_localizations);
  String get description => _args.description ?? _type.description(_localizations);
  String get inputHint => _args.inputHint ?? _type.inputHint(_localizations);

  bool get showEmojiPicker => _type == FeedbackType.general;
  void onEmojiSelected(EmojiFeedback feedback) {
    _selectedFeedback = feedback;
    notifyWidget();
  }

  String get buttonTitle => _localizations.feedbackButton;
  ButtonState get buttonState {
    if (_textEditingController.text.isEmpty && _selectedFeedback == null) return ButtonState.disabled;
    if (_isLoading) return ButtonState.loading;
    return ButtonState.enabled;
  }

  Future<void> onSendFeedbackButtonTap() async {
    _isLoading = true;
    notifyWidget();

    try {
      await _sendFeedbackUsecase.call(
        UserFeedback(
          type: _type,
          screen: _args.origin,
          rating: _selectedFeedback,
          message: _textEditingController.text,
        ),
      );

      _toast.showToast(message: _type.success(_localizations), type: ToastType.success);
      LmuVibrations.success();
      _navigatorState.pop();
      if (_selectedFeedback == EmojiFeedback.good) {
        await _requestAppReviewUsecase.call();
      }
    } catch (e) {
      _toast.showToast(message: _type.error(_localizations), type: ToastType.error);
      LmuVibrations.error();
      _isLoading = false;
      notifyWidget();
    }
  }

  void _onTextEditingControllerChanged() {
    final textLength = _textEditingController.text.length;
    if (textLength < 2) {
      notifyWidget();
    }
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onTextEditingControllerChanged);
  }

  @override
  void didUpdateProvidedProperties({
    required FeedbackArgs newArgs,
  }) {
    _args = newArgs;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals.feedback;
    _navigatorState = Navigator.of(context);
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.removeListener(_onTextEditingControllerChanged);
  }
}

extension on FeedbackType {
  String title(FeedbackLocalizations locals) {
    return switch (this) {
      FeedbackType.general => locals.feedbackTitle,
      FeedbackType.bug => locals.bugTitle,
      FeedbackType.suggestion => locals.suggestionTitle,
    };
  }

  String description(FeedbackLocalizations locals) {
    return switch (this) {
      FeedbackType.general => locals.feedbackDescription,
      FeedbackType.bug => locals.bugDescription,
      FeedbackType.suggestion => locals.suggestionDescription,
    };
  }

  String inputHint(FeedbackLocalizations locals) {
    return switch (this) {
      FeedbackType.general => locals.feedbackInputHint,
      FeedbackType.bug => locals.bugInputHint,
      FeedbackType.suggestion => locals.suggestionInputHint,
    };
  }

  String success(FeedbackLocalizations locals) {
    return switch (this) {
      FeedbackType.general => locals.feedbackSuccess,
      FeedbackType.bug => locals.bugSuccess,
      FeedbackType.suggestion => locals.suggestionSuccess,
    };
  }

  String error(FeedbackLocalizations locals) {
    return switch (this) {
      FeedbackType.general => locals.feedbackError,
      FeedbackType.bug => locals.bugError,
      FeedbackType.suggestion => locals.suggestionError,
    };
  }
}

class _TestTextEditingController extends EmptyDefault implements TextEditingController {
  const _TestTextEditingController();
}
