import 'package:core/api.dart';
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
    required this.id,
    required this.description,
    required this.url,
    required this.faviconUrl,
    required this.types,
    required this.rating,
  });

  final String id;
  final String description;
  final String url;
  final String? faviconUrl;
  final List<String> types;
  final RatingModel rating;
}

class LinksSearchPage extends StatefulWidget {
  const LinksSearchPage({super.key});

  @override
  State<LinksSearchPage> createState() => _LinksSearchPageState();
}

class _LinksSearchPageState extends State<LinksSearchPage> {
  late final LmuRecentSearchController<LinksSearchEntry>
      _recentSearchController;
  late final List<LinksSearchEntry> _searchEntries;
  late final List<LinksSearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<LinksSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<LinksSearchEntry>();
    final links = _searchService.links
        .map((link) => LinksSearchEntry(
              id: link.id,
              title: link.title,
              tags: link.faculties,
              description: link.description,
              url: link.url,
              faviconUrl: link.faviconUrl,
              types: link.types,
              rating: link.rating,
            ))
        .toList();

    _searchEntries = [...links];
    _recentSearchEntries = _searchService.recentSearches
        .map((link) => LinksSearchEntry(
              id: link.id,
              title: link.title,
              tags: link.faculties,
              description: link.description,
              url: link.url,
              faviconUrl: link.faviconUrl,
              types: link.types,
              rating: link.rating,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<LinksSearchEntry>(
      searchEntries: _searchEntries,
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) => _searchService
          .updateRecentSearch(recentSearchEntries.map((e) => e.id).toList()),
      searchEntryBuilder: (LinksSearchEntry input) => LinkCard(
        link: LinkModel(
          id: input.id,
          title: input.title,
          description: input.description,
          url: input.url,
          faviconUrl: input.faviconUrl,
          faculties: input.tags!,
          types: input.types,
          rating: input.rating,
        ),
        additionalCallbackOnTap: () => _recentSearchController.trigger(input),
      ),
    );
  }
}
