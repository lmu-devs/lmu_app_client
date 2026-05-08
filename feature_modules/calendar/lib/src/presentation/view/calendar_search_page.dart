import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/calendar_entry_card.dart';
import '../viewmodel/calendar_search_page_driver.dart';
import 'calendar_event_contentsheet.dart';

class CalendarSearchEntry extends SearchEntry {
  const CalendarSearchEntry({
    required super.title,
    required this.id,
    this.onlineLink,
    this.tags,
  });
  final String id;
  final String? onlineLink;
  final List<String>? tags;
}

class CalendarSearchPage extends DrivableWidget<CalendarSearchPageDriver> {
  CalendarSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recentSearchController = LmuRecentSearchController<CalendarSearchEntry>();

    final searchEntries = driver.allCalendarEntries
        .map((entry) => CalendarSearchEntry(title: entry.title, id: entry.id, onlineLink: entry.onlineLink, tags: [
              entry.location?.address ?? '',
              entry.onlineLink ?? '',
              entry.description ?? '',
              entry.onlineLink ?? '',
            ]))
        .toList();

    final recentSearchEntries = driver.recentSearchIds
        .map((id) {
          final entry = driver.getEntry(id);
          if (entry == null) return null;
          return CalendarSearchEntry(title: entry.title, id: entry.id, onlineLink: entry.onlineLink, tags: [
            entry.location?.address ?? '',
            entry.onlineLink ?? '',
            entry.description ?? '',
            entry.onlineLink ?? '',
          ]);
        })
        .whereType<CalendarSearchEntry>()
        .toList();

    final youngestFiveEntriesByCreationDate =
        (driver.allCalendarEntries.where((entry) => entry.createdAt != null).toList()
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!)))
            .take(5)
            .toList();

    return LmuSearchPage<CalendarSearchEntry>(
      searchEntries: searchEntries,
      emptySearchEntriesTitle: "Recently added events",
      emptySearchEntries: youngestFiveEntriesByCreationDate.map((entry) {
        return CalendarSearchEntry(title: entry.title, id: entry.id, tags: [
          entry.location?.address ?? '',
          entry.onlineLink ?? '',
          entry.description ?? '',
        ]);
      }).toList(),
      recentSearchEntries: recentSearchEntries,
      recentSearchController: recentSearchController,
      onRecentSearchesUpdated: (updatedEntries) =>
          driver.updateRecentSearches(updatedEntries.map((e) => e.id).toList()),
      searchEntryBuilder: (CalendarSearchEntry input) {
        final entry = driver.getEntry(input.id);
        if (entry == null) {
          // This can happen if a recent search item was deleted.
          return LmuListItem.action(
            title: 'Event not found',
            actionType: LmuListItemAction.checkbox,
          );
        }

        return SizedBox(
          width: double.infinity,
          child: CalendarCard(
            entry: entry,
            onTap: () {
              recentSearchController.trigger(input);
              showModalBottomSheet(
                context: context,
                builder: (context) => CalendarEventBottomSheet(event: entry),
              );
            },
          ),
        );
      },
    );
  }

  @override
  WidgetDriverProvider<CalendarSearchPageDriver> get driverProvider => $CalendarSearchPageDriverProvider();
}
