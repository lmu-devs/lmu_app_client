import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/services.dart';

class ExploreSearchEntry extends SearchEntry {
  const ExploreSearchEntry({required super.title, required this.id});

  final String id;
}

class ExploreSearchPage extends StatefulWidget {
  const ExploreSearchPage({super.key});

  @override
  State<ExploreSearchPage> createState() => _ExploreSearchPageState();
}

class _ExploreSearchPageState extends State<ExploreSearchPage> {
  late final LmuRecentSearchController<ExploreSearchEntry> _recentSearchController;
  late final List<ExploreSearchEntry> _searchEntries;
  late final List<ExploreSearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<ExploreSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<ExploreSearchEntry>();
    _searchEntries = [
      ExploreSearchEntry(title: "Title", id: "1"),
      ExploreSearchEntry(title: "Title", id: "2"),
      ExploreSearchEntry(title: "Title", id: "3"),
      ExploreSearchEntry(title: "Title", id: "4"),
    ];
    _recentSearchEntries = [
      ExploreSearchEntry(title: "345", id: "1"),
      ExploreSearchEntry(title: "34", id: "2"),
      ExploreSearchEntry(title: "342", id: "3"),
      ExploreSearchEntry(title: "Ti654le", id: "4"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<ExploreSearchEntry>(
      searchEntries: _searchEntries,
      emptySearchEntriesTitle: "Popular",
      emptySearchEntries: [],
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) =>
          _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.id).toList()),
      searchEntryBuilder: (ExploreSearchEntry input) {
        return LmuListItem.action(
          title: "Title",
          actionType: LmuListItemAction.chevron,
          onTap: () {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => _recentSearchController.trigger(input),
            );
          },
        );
      },
    );
  }
}
