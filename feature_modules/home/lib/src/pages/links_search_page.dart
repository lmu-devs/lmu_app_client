import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../service/links_search_service.dart';
import '../widgets/links/link_card.dart';

class LinksSearchEntry extends SearchEntry {
  const LinksSearchEntry({
    required super.title,
    super.tags,
    required this.description,
    required this.url,
    required this.faviconUrl,
    required this.types,
  });

  final String description;
  final String url;
  final String? faviconUrl;
  final List<String> types;
}

class LinksSearchPage extends StatefulWidget {
  const LinksSearchPage({super.key});

  @override
  State<LinksSearchPage> createState() => _LinksSearchPageState();
}

class _LinksSearchPageState extends State<LinksSearchPage> {
  late final LmuRecentSearchController<LinksSearchEntry> _recentSearchController;
  late final List<LinksSearchEntry> _searchEntries;
  late final List<LinksSearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<LinksSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<LinksSearchEntry>();
    final links = _searchService.links
        .map((link) => LinksSearchEntry(
              title: link.title,
              tags: link.aliases,
              description: link.description,
              url: link.url,
              faviconUrl: link.faviconUrl,
              types: link.types,
            ))
        .toList();

    _searchEntries = [...links];
    _recentSearchEntries = _searchService.recentSearches
        .map((link) => LinksSearchEntry(
              title: link.title,
              tags: link.aliases,
              description: link.description,
              url: link.url,
              faviconUrl: link.faviconUrl,
              types: link.types,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<LinksSearchEntry>(
      searchEntries: _searchEntries,
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) =>
          _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.title).toList()),
      searchEntryBuilder: (LinksSearchEntry input) => LinkCard(
        link: LinkModel(
          title: input.title,
          description: input.description,
          url: input.url,
          faviconUrl: input.faviconUrl,
          aliases: input.tags!,
          types: input.types,
        ),
        additionalCallbackOnTap: () => _recentSearchController.trigger(input),
      ),
    );
  }
}
