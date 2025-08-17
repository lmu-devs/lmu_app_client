import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/calendar_entry.dart';

class WeekdaySelector extends StatefulWidget {
  const WeekdaySelector({
    super.key,
    required this.selectedDate,
    required this.onDateTimeRangeSelected,
    required this.entries,
  });
  final DateTime selectedDate;
  final ValueChanged<DateTimeRange> onDateTimeRangeSelected;
  final List<CalendarEntry> entries;

  @override
  State<WeekdaySelector> createState() => _WeekdaySelectorState();
}

class _WeekdaySelectorState extends State<WeekdaySelector> {
  late PageController _weekPageController;

  @override
  void initState() {
    super.initState();
    const initialPage = 0;
    _weekPageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _weekPageController.dispose();
    super.dispose();
  }

  List<Color> _getEventColorsForDay(DateTime day) {
    final events = widget.entries
        .where((entry) =>
            entry.startTime.year == day.year && entry.startTime.month == day.month && entry.startTime.day == day.day)
        .toList();

    return events.map((e) => e.color).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = (constraints.maxWidth / 7);

        return SizedBox(
          height: itemHeight + LmuSizes.size_16,
          child: PageView.builder(
            controller: _weekPageController,
            onPageChanged: (pageIndex) {
              final newDate = DateTime.now().add(Duration(days: pageIndex * 7)).startOfWeek;
              widget.onDateTimeRangeSelected(newDate.dateTimeRangeFromDateTime);
            },
            itemBuilder: (context, pageIndex) {
              final startOfWeek = DateTime.now().add(Duration(days: pageIndex * 7)).startOfWeek;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  final date = startOfWeek.add(Duration(days: index));
                  final isSelected = date.isSameDay(widget.selectedDate);
                  final isToday = date.isSameDay(DateTime.now());
                  final eventColors = _getEventColorsForDay(date);

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Day of the week
                          LmuText.bodyXSmall(
                            DateFormat.E(Localizations.localeOf(context).languageCode).format(date),
                          ),
                          // The circular date
                          AspectRatio(
                            aspectRatio: 1,
                            child: GestureDetector(
                              onTap: () {
                                widget.onDateTimeRangeSelected(date.dateTimeRangeFromDateTime);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? context.colors.neutralColors.backgroundColors.tile
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LmuText.body(
                                      '${date.day}',
                                      color: isToday
                                          ? context.colors.brandColors.textColors.strongColors.active
                                          : isSelected
                                              ? context.colors.neutralColors.textColors.strongColors.base
                                              : context.colors.neutralColors.textColors.strongColors.active,
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: LmuSizes.size_2),
                                    if (eventColors.isNotEmpty)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: eventColors
                                            .take(3)
                                            .map((color) => Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_2),
                                                  child: Icon(Icons.circle, size: 6, color: color),
                                                ))
                                            .toList(),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }
}
