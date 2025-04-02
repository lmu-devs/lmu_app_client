import 'package:flutter/cupertino.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../components.dart';
import '../../constants.dart';

class AppReviewUtil {
  static Future<void> askForAppReview() async {
    InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  static Future<void> openStoreListing(BuildContext context, String errorMessage) async {
    InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.openStoreListing(appStoreId: LmuDevStrings.appStoreId);
    } else {
      if (context.mounted) {
        LmuToast.show(
          context: context,
          message: errorMessage,
          type: ToastType.error,
        );
      }
    }
  }
}
