import 'package:core/utils.dart';
import 'package:flutter/material.dart';

class WeekPicker extends StatelessWidget {
  const WeekPicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });
  final DateTime selectedDate;
  final ValueChanged<DateTimeRange> onDateSelected;

  @override
  Widget build(BuildContext context) {
    // Calculate the start of the current week (Monday)
    final startOfWeek = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final date = startOfWeek.add(Duration(days: index));
          final isSelected =
              date.day == selectedDate.day && date.month == selectedDate.month && date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => onDateSelected(date.dateTimeRangeFromDateTime),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'][index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
