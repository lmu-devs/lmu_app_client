import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/feedback.dart';

import '../../../application/state/feedback_state.dart';
import '../../../application/usecases/open_store_listing_usecase.dart';
import '../../../presentation/view/feedback_page.dart';

class FeedbackApiImpl extends FeedbackApi {
  FeedbackApiImpl(this._state, this._openStoreListingUsecase);

  final FeedbackState _state;
  final OpenStoreListingUseCase _openStoreListingUsecase;
  @override
  void showFeedback(BuildContext context, {required FeedbackArgs args}) {
    _state.args = args;
    LmuBottomSheet.showExtended(context, content: FeedbackPage());
  }

  @override
  Future<void> openStoreListing() => _openStoreListingUsecase.call();
}
