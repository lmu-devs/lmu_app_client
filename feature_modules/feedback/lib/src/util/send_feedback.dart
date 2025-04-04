import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/feedback_model.dart';
import '../repository/feedback_repository.dart';
import 'feedback_types.dart';

Future<void> sendFeedback({
  required BuildContext context,
  required FeedbackType type,
  required String? rating,
  required String? message,
  required String screen,
  required List<String>? tags,
}) async {
  final localizations = context.locals.feedback;

  String appVersion = _getAppVersion();
  String systemVersion = GetIt.I<String>(instanceName: 'systemVersion');

  await GetIt.I
      .get<FeedbackRepository>()
      .saveFeedback(
        FeedbackModel(
          type: type.getValue(),
          rating: rating,
          message: message,
          screen: screen,
          tags: tags,
          appVersion: appVersion,
          systemVersion: systemVersion,
        ),
      )
      .then(
    (_) {
      LmuToast.show(
        context: context,
        message: type == FeedbackType.general
            ? localizations.feedbackSuccess
            : type == FeedbackType.bug
                ? localizations.bugSuccess
                : localizations.suggestionSuccess,
        type: ToastType.success,
      );
      LmuVibrations.success();
    },
  ).onError(
    (e, _) {
      LmuToast.show(
        context: context,
        message: type == FeedbackType.general
            ? localizations.feedbackError
            : type == FeedbackType.bug
                ? localizations.bugError
                : localizations.suggestionError,
        type: ToastType.error,
      );
      LmuVibrations.error();
    },
  );
}

String _getAppVersion() {
  final appName = GetIt.I<String>(instanceName: 'appName');
  final appVersion = GetIt.I<String>(instanceName: 'appVersion');
  return '$appName $appVersion';
}
