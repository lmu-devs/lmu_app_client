import 'dart:io';
import 'package:flutter/services.dart';

class LmuVibrations {
  static Future<void> primary({Duration? delay}) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    HapticFeedback.mediumImpact();
  }

  static Future<void> secondary({Duration? delay}) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    HapticFeedback.lightImpact();
  }

  static Future<void> error({Duration? delay}) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    HapticFeedback.mediumImpact();
    sleep(const Duration(milliseconds: 100));
    HapticFeedback.lightImpact();
  }

  static Future<void> success({Duration? delay}) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    HapticFeedback.mediumImpact();
    sleep(const Duration(milliseconds: 140));
    HapticFeedback.heavyImpact();
  }
}
