import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/event_type.dart';

class MonthDaySelector extends StatefulWidget {
  const MonthDaySelector({
    super.key,
    required this.selectedDate,
    required this.onDateTimeRangeSelected,
    required this.entries,
  });
  final DateTime selectedDate;
  final ValueChanged<DateTimeRange> onDateTimeRangeSelected;
  final List<CalendarEntry> entries;

  @override
  State<MonthDaySelector> createState() => _MonthDaySelectorState();
}

class _MonthDaySelectorState extends State<MonthDaySelector> {
  late PageController _monthPageController;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime.now();
    _monthPageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _monthPageController.dispose();
    super.dispose();
  }

  List<Color> _getEventColorsForDay(DateTime day) {
    final events = widget.entries.where((entry) => day.isSameDay(entry.startTime)).toList();
    return events.map((e) => e.color ?? e.eventType.defaultColor).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the number of days in the month and the first day's weekday
        final daysInMonth = DateTimeExtension.daysInMonth(widget.selectedDate);
        final firstDayWeekday = DateTimeExtension.firstDayWeekday(widget.selectedDate);
        final numRows = ((daysInMonth + firstDayWeekday - 1) / 7).ceil();
        final cellHeight = constraints.maxWidth / 7;
        final totalHeight = (cellHeight * numRows) + LmuSizes.size_32;

        return SizedBox(
          height: totalHeight,
          child: Column(
            children: [
              // Weekday names header (Mo, Tu, etc.)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    // Adjusting index to start on Monday
                    // TODO: if locale starts on Sunday, this might need a check
                    final weekday = (index + 1) % 7;
                    final day = DateTime(2025, 1, 6 + weekday); // A Monday date
                    return Expanded(
                      child: LmuText.bodyXSmall(
                        DateFormat.E(Localizations.localeOf(context).languageCode).format(day),
                        textAlign: TextAlign.center,
                        color: context.colors.neutralColors.textColors.strongColors.base,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: LmuSizes.size_8),
              // calendar grid
              Expanded(
                child: PageView.builder(
                  controller: _monthPageController,
                  onPageChanged: (pageIndex) {
                    setState(() {
                      _displayedMonth = DateTime(
                        DateTime.now().year,
                        DateTime.now().month + pageIndex,
                        1,
                      );
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    final month = DateTime(
                      _displayedMonth.year,
                      _displayedMonth.month,
                      1,
                    );
                    final daysInMonth = DateTimeExtension.daysInMonth(month);
                    final firstDayWeekday = DateTimeExtension.firstDayWeekday(month);

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: daysInMonth + firstDayWeekday - 1,
                      itemBuilder: (context, index) {
                        if (index < firstDayWeekday - 1) {
                          return const SizedBox.shrink(); // Empty "days"
                        }

                        final day = index - (firstDayWeekday - 2);
                        final date = DateTime(month.year, month.month, day);
                        final isSelected = date.isSameDay(widget.selectedDate);
                        final isToday = date.isSameDay(DateTime.now());
                        final eventColors = _getEventColorsForDay(date);

                        return GestureDetector(
                          onTap: () {
                            widget.onDateTimeRangeSelected(date.dateTimeRangeFromDateTime);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(LmuSizes.size_8),
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
                                    '$day',
                                    color: isToday
                                        ? context.colors.brandColors.textColors.strongColors.active
                                        : isSelected
                                            ? context.colors.neutralColors.textColors.strongColors.base
                                            : context.colors.neutralColors.textColors.strongColors.active,
                                    weight: FontWeight.bold,
                                  ),
                                  if (eventColors.isNotEmpty)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: eventColors
                                          .take(3)
                                          .map((color) => Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_2),
                                                child: Icon(Icons.circle, size: LmuSizes.size_6, color: color),
                                              ))
                                          .toList(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
