import 'package:core/components.dart';

import '../repository/api/models/sports_course.dart';

extension SportsStatusColorExtension on List<SportsCourse> {
  StatusColor get statusColor {
    int availableCount = where((course) => course.isAvailable).length;
    double availabilityRatio = availableCount / length;

    if (availabilityRatio == 0) {
      return StatusColor.red;
    } else if (availabilityRatio < 0.5) {
      return StatusColor.yellow;
    } else {
      return StatusColor.green;
    }
  }
}
