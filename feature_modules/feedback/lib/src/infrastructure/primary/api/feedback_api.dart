import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/feedback.dart';

import '../../../application/usecases/open_store_listing_usecase.dart';
import '../../../presentation/view/feedback_page.dart';

class FeedbackApiImpl extends FeedbackApi {
  FeedbackApiImpl(this._openStoreListingUsecase);

  final OpenStoreListingUseCase _openStoreListingUsecase;

  @override
  void showFeedback(BuildContext context, {required FeedbackArgs args}) {
    LmuBottomSheet.showExtended(context, content: FeedbackPage(args: args));
  }

  @override
  Future<void> openStoreListing() => _openStoreListingUsecase.call();
}
