import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';

extension EquipmentIconExtension on EquipmentModel {
  IconData getIcon() {
    return switch (type) {
      'ACCESSIBILITY' => LucideIcons.accessibility,
      'COPIER' => LucideIcons.printer,
      'BOOK_SCANNER' => LucideIcons.scan_text,
      'BEAMER_RENTAL' => LucideIcons.presentation,
      'WIFI' => LucideIcons.wifi,
      'INDIVIDUAL_WORK_ROOMS' => LucideIcons.user,
      'GROUP_WORK_ROOMS' => LucideIcons.users,
      'OTHER_ROOMS' => LucideIcons.door_open,
      'LOCKERS' => LucideIcons.lock,
      'FOOD_AND_DRINKS' => LucideIcons.donut,
      _ => LucideIcons.check,
    };
  }
}
