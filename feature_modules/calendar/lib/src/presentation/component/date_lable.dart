import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LmuDateLabel extends StatelessWidget {
  final DateTime date;

  const LmuDateLabel({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final input = DateTime(date.year, date.month, date.day);
    final diff = input.difference(today).inDays;

    String prefix;
    if (diff == 0) {
      prefix = 'Heute';
    } else if (diff == -1) {
      prefix = 'Gestern';
    } else if (diff == 1) {
      prefix = 'Morgen';
    } else {
      prefix = '';
    }

    final weekday = DateFormat.EEEE('de_DE').format(date);
    final dayMonth = DateFormat('d. MMMM', 'de_DE').format(date);
    final text = [if (prefix.isNotEmpty) prefix, weekday, dayMonth].join(', ');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Half-circle indicator if today
        if (diff == 0)
          Container(
            width: 12,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white, // customize this color
              borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
            ),
          )
        else
          const SizedBox(width: 12), // maintain alignment

        const SizedBox(width: 8),

        /// Date text
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
