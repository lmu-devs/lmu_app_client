import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

enum LeadingAction { back, close }

extension LeadingActionIconExtension on LeadingAction {
  IconData get icon {
    return switch (this) {
      LeadingAction.back => LucideIcons.arrow_left,
      LeadingAction.close => LucideIcons.x,
    };
  }
}
