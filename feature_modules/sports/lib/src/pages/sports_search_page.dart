import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/sports.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../extensions/sports_status_color_extension.dart';
import '../services/sports_search_service.dart';

class SportsSearchEntry extends SearchEntry {
  const SportsSearchEntry({required super.title});
}

class SportsSearchPage extends StatefulWidget {
  const SportsSearchPage({super.key});

  @override
  State<SportsSearchPage> createState() => _SportsSearchPageState();
}

class _SportsSearchPageState extends State<SportsSearchPage> {
  late final LmuRecentSearchController<SportsSearchEntry> _recentSearchController;
  late final List<SportsSearchEntry> _searchEntries;
  late final List<SportsSearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<SportsSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<SportsSearchEntry>();
    _searchEntries = _searchService.sportsTypes.map((sport) => SportsSearchEntry(title: sport.title)).toList();
    _recentSearchEntries = _searchService.recentSearches.map((sport) => SportsSearchEntry(title: sport.title)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<SportsSearchEntry>(
      searchEntries: _searchEntries,
      emptySearchEntriesTitle: context.locals.sports.recommendations,
      emptySearchEntries:
          _searchService.sportsRecommendations.map((sport) => SportsSearchEntry(title: sport.title)).toList(),
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) =>
          _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.title).toList()),
      searchEntryBuilder: (SportsSearchEntry input) {
        final sport = _searchService.getSportType(input.title);
        return LmuListItem.action(
          title: sport.title,
          actionType: LmuListItemAction.chevron,
          leadingArea: LmuStatusDot(statusColor: sport.courses.statusColor),
          onTap: () {
            SportsDetailsRoute(sport).push(context);
            _recentSearchController.trigger(input);
          },
        );
      },
    );
  }
}
