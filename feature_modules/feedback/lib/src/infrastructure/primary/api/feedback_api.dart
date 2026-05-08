import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/feedback.dart';

import '../../../domain/interfaces/app_review_repository_interface.dart';
import '../../../presentation/view/feedback_page.dart';

class FeedbackApiImpl extends FeedbackApi {
  FeedbackApiImpl(this._appReviewRepository);

  final AppReviewRepositoryInterface _appReviewRepository;

  @override
  void showFeedback(BuildContext context, {required FeedbackArgs args}) {
    LmuBottomSheet.showExtended(context, content: FeedbackPage(args: args));
  }

  @override
  Future<void> openStoreListing() => _appReviewRepository.openStoreListing();
}
