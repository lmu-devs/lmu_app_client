import 'package:flutter/material.dart';

import '../feedback.dart';

abstract class FeedbackApi {
  void showFeedback(BuildContext context, {required FeedbackArgs args});

  Future<void> openStoreListing();
}
