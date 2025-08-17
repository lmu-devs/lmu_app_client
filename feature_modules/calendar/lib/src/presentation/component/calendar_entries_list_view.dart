import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
// class CalendarEntriesListView extends StatefulWidget {
//   const CalendarEntriesListView({
//     super.key,
//     required this.entries,
//     this.selectedDate,
//   });

//   final List<CalendarEntry> entries;
//   final DateTime? selectedDate;

//   @override
//   State<CalendarEntriesListView> createState() => _CalendarEntriesListViewState();
// }

// class _CalendarEntriesListViewState extends State<CalendarEntriesListView> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToSelectedDate();
//     });
//   }

//   void _scrollToSelectedDate() {
//     if (widget.selectedDate == null || widget.entries.isEmpty) return;

//     final sortedEntries = List<CalendarEntry>.from(widget.entries)..sort((a, b) => a.startTime.compareTo(b.startTime));

//     final index = sortedEntries.indexWhere((entry) {
//       return entry.startTime.isSameDay(widget.selectedDate!);
//     });

//     if (index != -1) {
//       _scrollController.jumpTo(
//         index * 120.0,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.entries.isEmpty) {
//       return const Center(child: Text('No entries found.'));
//     }

//     final listItems = _buildItemList(context);

//     return ListView(
//       controller: _scrollController,
//       children: listItems,
//     );
//   }

//   List<Widget> _buildItemList(BuildContext context) {
//     final List<Widget> items = [];
//     DateTime? lastDate;

//     final sortedEntries = List<CalendarEntry>.from(widget.entries)..sort((a, b) => a.startTime.compareTo(b.startTime));

//     final now = DateTime.now();

//     for (int i = 0; i < sortedEntries.length; i++) {
//       final event = sortedEntries[i];
//       final currentDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);

//       final isNewDay = lastDate == null || !currentDate.isAtSameMomentAs(lastDate);

//       if (isNewDay) {
//         if (lastDate != null) {
//           final daysBetween = currentDate.difference(lastDate).inDays;

//           if (daysBetween > 1) {
//             // Always show empty range for any gap > 1 day between entries
//             items.add(
//               CalendarDateInfoLabel.emptyRange(
//                 lastDate: lastDate,
//                 currentDate: currentDate,
//               ),
//             );
//           }

//           final isNextYear = currentDate.year != (lastDate.year);

//           if (isNextYear) {
//             items.add(
//               CalendarDateInfoLabel.year(
//                 date: currentDate,
//               ),
//             );
//           }

//           // If month changes, show month label
//           if (currentDate.month != lastDate.month) {
//             items.add(
//               CalendarDateInfoLabel.month(
//                 date: currentDate,
//               ),
//             );
//           }
//         } else {
//           // First entry also needs a month label
//           items.add(
//             CalendarDateInfoLabel.month(
//               date: currentDate,
//             ),
//           );
//         }

//         // Always show day label for the first entry of that day
//         final diff = currentDate.difference(DateTime(now.year, now.month, now.day)).inDays;
//         items.add(
//           CalendarDateInfoLabel.day(
//             date: currentDate,
//             isToday: diff == 0,
//           ),
//         );

//         lastDate = currentDate;
//       }

//       // Add the entry card
//       items.add(
//         Padding(
//           padding: const EdgeInsets.fromLTRB(LmuSizes.size_8, 0, LmuSizes.size_8, LmuSizes.size_6),
//           child: CalendarCard(
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) => CalendarEventBottomSheet(event: event),
//               );
//             },
//             key: Key("calendar_event_${event.id}"),
//             entry: event,
//           ),
//         ),
//       );

//       // End marker
//       if (i == sortedEntries.length - 1) {
//         items.add(
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_32),
//             child: LmuText.bodySmall(
//               'No more entries',
//               textAlign: TextAlign.center,
//               color: context.colors.neutralColors.textColors.weakColors.base,
//             ),
//           ),
//         );
//       }
//     }

//     return items;
//   }
// }

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../domain/model/calendar_entry.dart';
import '../view/calendar_event_contentsheet.dart';
import 'calendar_date_info_label.dart';
import 'calendar_entry_card.dart';

class CalendarEntriesListView extends StatefulWidget {
  const CalendarEntriesListView({
    super.key,
    required this.entries,
    this.selectedDate,
    this.scrollToDateRequest = 0,
  });

  final List<CalendarEntry> entries;
  final DateTime? selectedDate;
  final int scrollToDateRequest;

  @override
  State<CalendarEntriesListView> createState() => _CalendarEntriesListViewState();
}

class _CalendarEntriesListViewState extends State<CalendarEntriesListView> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  late List<Widget> _listItems;

  bool _isInitialScroll = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _listItems = _buildItemList(context);

    if (_isInitialScroll) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedDate();
        _isInitialScroll = false;
      });
    }
  }

  @override
  void didUpdateWidget(CalendarEntriesListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Checking efficiently with O(N) if the data has actually changed before doing expensive work :D
    bool listsAreEqual = const ListEquality().equals(oldWidget.entries, widget.entries);

    if (!listsAreEqual) {
      setState(() {
        _listItems = _buildItemList(context);
      });
    }

    // If the selectedDate changed or a scroll to today has been requested, we need to scroll.
    if (oldWidget.selectedDate != widget.selectedDate || oldWidget.scrollToDateRequest != widget.scrollToDateRequest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedDate();
      });
    }
  }

  void _scrollToSelectedDate() {
    if (widget.selectedDate == null || widget.entries.isEmpty) return;

    int targetIndex = -1;

    // Find the index of the first CalendarDateInfoLabel.day/emptyRange that matches the selected date.
    for (int i = 0; i < _listItems.length; i++) {
      final item = _listItems[i];
      if (item is CalendarDateInfoLabel) {
        if (i == 2 && widget.selectedDate!.isBefore(item.date!)) {
          // The first item is always "not prior entries" info, the second is always a CalendarLabelType.month item
          // So we look for the third elements date
          targetIndex = 0;
          break;
        }
        if (i == _listItems.length - 3 && widget.selectedDate!.isAfter(item.date!)) {
          // the last element is always a "no more entries" info
          // So we look for the second to last elements date
          targetIndex = _listItems.length - 1;
          break;
        }
        if (item.type == CalendarLabelType.day) {
          if (item.date!.isSameDay(widget.selectedDate!)) {
            targetIndex = i;
            break;
          }
        }
        if (item.type == CalendarLabelType.emptyRange) {
          if ((widget.selectedDate!.isAfter(item.lastDate!.add(const Duration(days: 1))) &&
                  widget.selectedDate!.isBefore(item.currentDate!.subtract(const Duration(days: 1)))) ||
              widget.selectedDate!.isSameDay(item.lastDate!.add(const Duration(days: 1))) ||
              widget.selectedDate!.isSameDay(item.currentDate!.subtract(const Duration(days: 1)))) {
            targetIndex = i;
            break;
          }
        }
      }
    }

    if (targetIndex != -1) {
      _itemScrollController.scrollTo(
        index: targetIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entries.isEmpty) {
      return const Center(child: Text('No entries found.'));
    }

    return ScrollablePositionedList.builder(
      itemCount: _listItems.length,
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      itemBuilder: (context, index) {
        return _listItems[index];
      },
    );
  }

  List<Widget> _buildItemList(BuildContext context) {
    final List<Widget> items = [];
    DateTime? lastDate;

    final sortedEntries = List<CalendarEntry>.from(widget.entries)..sort((a, b) => a.startTime.compareTo(b.startTime));

    final now = DateTime.now();
    if (sortedEntries.isNotEmpty) {
      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_32),
          child: LmuText.bodySmall(
            'No prior entries',
            textAlign: TextAlign.center,
            color: context.colors.neutralColors.textColors.weakColors.base,
          ),
        ),
      );
    }
    for (int i = 0; i < sortedEntries.length; i++) {
      final event = sortedEntries[i];
      final currentDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);

      final isNewDay = lastDate == null || !currentDate.isAtSameMomentAs(lastDate);

      if (isNewDay) {
        if (lastDate != null) {
          final daysBetween = currentDate.difference(lastDate).inDays;

          if (daysBetween > 1) {
            items.add(
              CalendarDateInfoLabel.emptyRange(
                lastDate: lastDate,
                currentDate: currentDate,
              ),
            );
          }

          final isNextYear = currentDate.year != (lastDate.year);

          if (isNextYear) {
            items.add(
              CalendarDateInfoLabel.year(
                date: currentDate,
              ),
            );
          }
          if (currentDate.month != lastDate.month) {
            items.add(
              CalendarDateInfoLabel.month(
                date: currentDate,
              ),
            );
          }
        } else {
          items.add(
            CalendarDateInfoLabel.month(
              date: currentDate,
            ),
          );
        }
        final diff = currentDate.difference(DateTime(now.year, now.month, now.day)).inDays;
        items.add(
          CalendarDateInfoLabel.day(
            date: currentDate,
            isToday: diff == 0,
          ),
        );
        lastDate = currentDate;
      }
      items.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(LmuSizes.size_8, 0, LmuSizes.size_8, LmuSizes.size_6),
          child: CalendarCard(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => CalendarEventBottomSheet(event: event),
              );
            },
            key: Key("calendar_event_${event.id}"),
            entry: event,
          ),
        ),
      );
      if (i == sortedEntries.length - 1) {
        items.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_32),
            child: LmuText.bodySmall(
              'No more entries',
              textAlign: TextAlign.center,
              color: context.colors.neutralColors.textColors.weakColors.base,
            ),
          ),
        );
      }
    }
    return items;
  }
}
