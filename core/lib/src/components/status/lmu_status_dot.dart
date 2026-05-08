import 'package:flutter/widgets.dart';

import '../../../constants.dart';
import '../../../themes.dart';

enum StatusColor {
  green,
  yellow,
  red,
}

class LmuStatusDot extends StatelessWidget {
  const LmuStatusDot({super.key, this.statusColor = StatusColor.green});

  final StatusColor statusColor;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: LmuSizes.size_8,
        height: LmuSizes.size_8,
        color: _getStatusColor(statusColor, colors: context.colors),
      ),
    );
  }

  Color _getStatusColor(StatusColor statusColor, {required LmuColors colors}) {
    return switch (statusColor) {
      StatusColor.green => colors.successColors.textColors.strongColors.base,
      StatusColor.yellow => colors.warningColors.textColors.strongColors.base,
      StatusColor.red => colors.dangerColors.textColors.strongColors.base,
    };
  }
}
