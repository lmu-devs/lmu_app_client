import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/libraries.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/libraries_search_service.dart';

class LibrarySearchEntry extends SearchEntry {
  const LibrarySearchEntry({required super.title, required this.id});

  final String id;
}

class LibrariesSearchPage extends StatefulWidget {
  const LibrariesSearchPage({super.key});

  @override
  State<LibrariesSearchPage> createState() => _LibrariesSearchPageState();
}

class _LibrariesSearchPageState extends State<LibrariesSearchPage> {
  late final LmuRecentSearchController<LibrarySearchEntry> _recentSearchController;
  late final List<LibrarySearchEntry> _searchEntries;
  late final List<LibrarySearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<LibrariesSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<LibrarySearchEntry>();
    _searchEntries =
        _searchService.libraries.map((library) => LibrarySearchEntry(title: library.name, id: library.id)).toList();
    _recentSearchEntries = _searchService.recentSearchIds.map((id) {
      final library = _searchService.getLibrary(id);
      return LibrarySearchEntry(title: library.name, id: id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<LibrarySearchEntry>(
      searchEntries: _searchEntries,
      emptySearchEntriesTitle: context.locals.roomfinder.popular,
      emptySearchEntries: _searchService.popularLibraries
          .map((library) => LibrarySearchEntry(title: library.name, id: library.id))
          .toList(),
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) =>
          _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.id).toList()),
      searchEntryBuilder: (LibrarySearchEntry input) {
        final library = _searchService.getLibrary(input.id);
        return LmuListItem.action(
          title: library.name,
          actionType: LmuListItemAction.chevron,
          onTap: () {
            LibraryDetailsRoute(library).go(context);
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
