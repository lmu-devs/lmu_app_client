import 'dart:io';
import 'package:flutter/services.dart';

enum VibrationType { primary, secondary, error, success }

class VibrationPatterns {
  static void vibrate(VibrationType type) async {
    switch (type) {
      case VibrationType.primary:
        HapticFeedback.mediumImpact();
        break;
      case VibrationType.secondary:
        HapticFeedback.lightImpact();
        break;
      case VibrationType.error:
        HapticFeedback.mediumImpact();
        sleep(const Duration(milliseconds: 100));
        HapticFeedback.lightImpact();
        break;
      case VibrationType.success:
        HapticFeedback.mediumImpact();
        sleep(const Duration(milliseconds: 130));
        HapticFeedback.heavyImpact();
        break;
    }
  }
}
