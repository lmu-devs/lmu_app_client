import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/people_search_driver.dart';

class PeopleSearchPage extends DrivableWidget<PeopleSearchDriver> {
  PeopleSearchPage({super.key, required this.facultyId});

  final int facultyId;

  @override
  PeopleSearchDriver createDriver() => GetIt.I<PeopleSearchDriver>(param1: facultyId);

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<PeopleSearchEntry>(
      searchEntries: driver.searchEntries,
      emptySearchEntriesTitle: context.locals.app.prevSearch,
      emptySearchEntries: driver.recommendedEntries,
      recentSearchEntries: driver.recentSearchEntries,
      recentSearchController: driver.recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) => driver.updateRecentSearch(recentSearchEntries),
      searchEntryBuilder: (PeopleSearchEntry entry) {
        final person = entry.person;
        return LmuListItem.action(
          title: '${person.name} ${person.surname}',
          subtitle: person.title.isNotEmpty ? person.title : person.role,
          actionType: LmuListItemAction.chevron,
          onTap: () {
            driver.onPersonPressed(context, person);
            driver.recentSearchController.trigger(entry);
          },
        );
      },
    );
  }

  @override
  WidgetDriverProvider<PeopleSearchDriver> get driverProvider => $PeopleSearchDriverProvider(facultyId: facultyId);
}
