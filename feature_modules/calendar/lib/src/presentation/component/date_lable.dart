import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/model/helper/date_time_formatter.dart';

class LmuDateLabel extends StatelessWidget {
  const LmuDateLabel({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final input = DateTime(date.year, date.month, date.day);
    final diff = input.difference(today).inDays;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Half-circle indicator if today
        if (diff == 0)
          Container(
            width: LmuSizes.size_12,
            height: LmuSizes.size_24,
            decoration: const BoxDecoration(
              color: Colors.white, // customize this color
              borderRadius: BorderRadius.horizontal(right: Radius.circular(LmuRadiusSizes.round)),
            ),
          )
        else
          const SizedBox(width: 12), // maintain alignment

        const SizedBox(width: 8),

        /// Date text
        LmuText.body(
          DateTimeFormatter.formatShortDate(date),
        ),
      ],
    );
  }
}
