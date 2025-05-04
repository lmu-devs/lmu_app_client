import 'package:flutter/material.dart';

import '../feedback.dart';

abstract class FeedbackApi {
  void showFeedback(BuildContext context, {required String origin, required FeedbackType type});

  Future<void> openStoreListing();
}
