import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

enum LeadingAction {
  back,
  close,
}

extension LeadingActionIconExtension on LeadingAction {
  IconData get icon {
    switch (this) {
      case LeadingAction.back:
        return LucideIcons.arrow_left;
      case LeadingAction.close:
        return LucideIcons.x;
    }
  }
}
