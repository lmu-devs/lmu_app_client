import 'package:core/constants.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../domain/interfaces/app_review_repository_interface.dart';

class AppReviewRepository implements AppReviewRepositoryInterface {
  final InAppReview _inAppReview = InAppReview.instance;

  @override
  Future<void> requestReview() async {
    if (!await _inAppReview.isAvailable()) return;
    await _inAppReview.requestReview();
  }

  @override
  Future<void> openStoreListing() async {
    if (!await _inAppReview.isAvailable()) return;
    await _inAppReview.openStoreListing(appStoreId: LmuDevStrings.appStoreId);
  }
}
