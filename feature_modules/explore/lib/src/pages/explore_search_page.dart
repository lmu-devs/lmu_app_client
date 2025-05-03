import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../extensions/explore_marker_type_extension.dart';
import '../services/services.dart';

class ExploreSearchEntry extends SearchEntry {
  const ExploreSearchEntry({required super.title, required this.id, required this.type, this.lat = 0, this.long = 0});

  final String id;
  final ExploreMarkerType type;
  final double lat;
  final double long;
}

class ExploreSearchPage extends StatefulWidget {
  const ExploreSearchPage({super.key});

  @override
  State<ExploreSearchPage> createState() => _ExploreSearchPageState();
}

class _ExploreSearchPageState extends State<ExploreSearchPage> {
  late final LmuRecentSearchController<ExploreSearchEntry> _recentSearchController;
  late List<ExploreSearchEntry> _searchEntries;
  late List<ExploreSearchEntry> _recentSearchEntries;
  late List<ExploreSearchEntry> _nearbySearchEntries;

  final _searchService = GetIt.I.get<ExploreSearchService>();
  final _exploreMapService = GetIt.I.get<ExploreMapService>();
  final _exploreLocationService = GetIt.I.get<ExploreLocationService>();
  final _locationService = GetIt.I.get<LocationService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<ExploreSearchEntry>();
    _onExploreLocations();
    _exploreLocationService.exploreLocationsNotifier.addListener(_onExploreLocations);
  }

  @override
  void dispose() {
    _exploreLocationService.exploreLocationsNotifier.removeListener(_onExploreLocations);
    super.dispose();
  }

  void _onExploreLocations() {
    _searchEntries = _exploreLocationService.exploreLocationsNotifier.value
        .map((location) => ExploreSearchEntry(
              title: location.name,
              id: location.id,
              type: location.type,
              lat: location.latitude,
              long: location.longitude,
            ))
        .toList();

    final recentSearch = _searchService.recentSearches;
    final recentSearchLocations = _searchEntries.where((location) => recentSearch.contains(location.id)).toList();
    final sortedRecentSearchLocations = recentSearchLocations
      ..sort((a, b) {
        final aIndex = recentSearch.indexOf(a.id);
        final bIndex = recentSearch.indexOf(b.id);
        return aIndex.compareTo(bIndex);
      });
    _recentSearchEntries = sortedRecentSearchLocations
        .map((location) => ExploreSearchEntry(
              title: location.title,
              id: location.id,
              type: location.type,
              lat: location.lat,
              long: location.long,
            ))
        .toList();

    final closeByEntires = _searchEntries
        .where(
          (entry) => (_locationService.getDistance(lat: entry.lat, long: entry.long) ?? 2000) < 1000,
        )
        .toList();

    closeByEntires.sort((a, b) {
      final aDistance = _locationService.getDistance(
        lat: a.lat,
        long: a.long,
      );
      final bDistance = _locationService.getDistance(
        lat: b.lat,
        long: b.long,
      );
      if (aDistance == null || bDistance == null) {
        return 0;
      }
      return aDistance.compareTo(bDistance);
    });

    _nearbySearchEntries = closeByEntires.take(4).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<ExploreSearchEntry>(
      searchEntries: _searchEntries,
      emptySearchEntriesTitle: context.locals.explore.nearby,
      emptySearchEntries: _nearbySearchEntries,
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) =>
          _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.id).toList()),
      searchEntryBuilder: (ExploreSearchEntry input) {
        final distance = _locationService.getDistance(lat: input.lat, long: input.long);
        return LmuListItem.action(
          title: input.title,
          leadingArea: LmuIcon(
            icon: input.type.icon,
            size: LmuIconSizes.medium,
            color: input.type.markerColor(context.colors),
          ),
          trailingTitle: distance?.formatDistance(),
          actionType: LmuListItemAction.chevron,
          onTap: () {
            Navigator.of(context).pop();
            final location = _exploreLocationService.getLocationById(input.id);
            _exploreMapService.focusMarker(location);
            _exploreLocationService.bringToFront(input.id);
            _exploreLocationService.ensureLocationVisible(location);
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
