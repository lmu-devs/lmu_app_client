import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_entries_by_date_usecase.dart';
import '../../application/usecase/recent_searches_usecase.dart';
import '../../domain/model/calendar_entry.dart';
import '../component/calendar_entry_card.dart';
import '../view/calendar_event_contentsheet.dart';

part 'calendar_search_page_driver.g.dart';

class CalendarSearchEntry extends SearchEntry {
  const CalendarSearchEntry({
    required super.title,
    required this.id,
    this.onlineLink,
    this.tags,
  });
  final List<String>? tags;
  final String id;
  final String? onlineLink;
}

@GenerateTestDriver()
class CalendarSearchPageDriver extends WidgetDriver {
  late CalendarLocatizations _localizations;

  @TestDriverDefaultValue([])
  final _calendarEntriesUsecase = GetIt.I.get<GetCalendarEntriesByDateUsecase>();
  final _recentSearchController = LmuRecentSearchController<CalendarSearchEntry>();
  final _recentSearchesUsecase = GetIt.I.get<RecentSearchesUsecase>();

  @TestDriverDefaultValue([])
  List<CalendarEntry> get recentSearches => _recentSearchesUsecase.recentSearches;

  @TestDriverDefaultValue([])
  List<CalendarEntry> get calendarEntries => _calendarEntriesUsecase.data;

  @TestDriverDefaultValue(_TestLmuRecentSearchController())
  LmuRecentSearchController<CalendarSearchEntry> get recentSearchController => _recentSearchController;

  List<CalendarSearchEntry> get searchEntries => calendarEntries
      .map((entry) => CalendarSearchEntry(title: entry.title, id: entry.id, onlineLink: entry.onlineLink, tags: [
            entry.location?.address ?? '',
            entry.onlineLink ?? '',
            entry.description ?? '',
            entry.onlineLink ?? '',
          ]))
      .toList();

  List<CalendarSearchEntry> get recentSearchEntries => recentSearches
      .map((entry) => CalendarSearchEntry(title: entry.title, id: entry.id, onlineLink: entry.onlineLink, tags: [
            entry.location?.address ?? '',
            entry.onlineLink ?? '',
            entry.description ?? '',
            entry.onlineLink ?? '',
          ]))
      .toList();

  String get youngestEntriesTitle => _localizations.calendar.recentlyAddedEvents;

  List<CalendarSearchEntry> get youngestFiveEntriesByCreationDate {
    final sorted = calendarEntries.where((e) => e.createdAt != null).toList()
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return sorted.take(5).map((entry) {
      return CalendarSearchEntry(
        title: entry.title,
        id: entry.id,
        onlineLink: entry.onlineLink,
        tags: [
          entry.location?.address ?? '',
          entry.onlineLink ?? '',
          entry.description ?? '',
        ],
      );
    }).toList();
  }

  CalendarEntry? getEntry(String id) {
    try {
      return calendarEntries.firstWhere((entry) => entry.id == id);
    } catch (e) {
      return null;
    }
  }

  Widget buildSearchEntry(BuildContext context, CalendarSearchEntry calendarEntry) {
    final entry = getEntry(calendarEntry.id);
    if (entry == null) {
      // This might happen if a recent search item was deleted.
      return LmuListItem.action(
        title: _localizations.calendar.eventNotFound,
        actionType: LmuListItemAction.checkbox,
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_2),
        child: CalendarCard(
          entry: entry,
          onTap: () {
            addRecentSearch(calendarEntry.id);
            recentSearchController.trigger(calendarEntry);
            showModalBottomSheet(
              context: context,
              builder: (context) => CalendarEventBottomSheet(event: entry),
            );
          },
        ),
      ),
    );
  }

  Future<void> addRecentSearch(String calendarEntryId) async {
    await _recentSearchesUsecase.addRecentSearch(calendarEntryId);
  }

  void updateRecentSearch(List<CalendarSearchEntry> recentSearchEntries) {
    if (recentSearchEntries.isEmpty) {
      _recentSearchesUsecase.clearRecentSearches();
    } else {
      for (final entry in recentSearchEntries) {
        _recentSearchesUsecase.addRecentSearch(entry.id);
      }
    }
  }
}

class _TestLmuRecentSearchController extends EmptyDefault implements LmuRecentSearchController<CalendarSearchEntry> {
  const _TestLmuRecentSearchController();
}
