import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/roomfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../services/roomfinder_search_service.dart';

enum RoomfinderSearchEntryType { building, room }

class RoomfinderSearchEntry extends SearchEntry {
  const RoomfinderSearchEntry({required super.title, required this.id, super.tags, required this.type, this.subtitle});

  final RoomfinderSearchEntryType type;
  final String id;
  final String? subtitle;
}

class RoomfinderSearchPage extends StatefulWidget {
  const RoomfinderSearchPage({super.key});

  @override
  State<RoomfinderSearchPage> createState() => _RoomfinderSearchPageState();
}

class _RoomfinderSearchPageState extends State<RoomfinderSearchPage> {
  late final LmuRecentSearchController<RoomfinderSearchEntry> _recentSearchController;
  late final List<RoomfinderSearchEntry> _searchEntries;
  late final List<RoomfinderSearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<RoomfinderSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<RoomfinderSearchEntry>();
    final buildings = _searchService.buildings
        .map((building) => RoomfinderSearchEntry(
              title: building.title,
              id: building.buildingPartId,
              type: RoomfinderSearchEntryType.building,
              subtitle: building.location.address,
            ))
        .toList();

    _searchEntries = [...buildings];
    _recentSearchEntries = _searchService.recentSearches
        .map((building) => RoomfinderSearchEntry(
              title: building.title,
              id: building.buildingPartId,
              type: RoomfinderSearchEntryType.building,
              subtitle: building.location.address,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<RoomfinderSearchEntry>(
      searchEntries: _searchEntries,
      emptySearchEntriesTitle: context.locals.roomfinder.popular,
      emptySearchEntries: [_searchEntries[0], _searchEntries[1]],
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) =>
          _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.id).toList()),
      searchEntryBuilder: (RoomfinderSearchEntry input) {
        return LmuListItem.action(
          title: input.subtitle,
          actionType: LmuListItemAction.chevron,
          // leadingArea: LmuIcon(
          //   icon: input.type.icon,
          //   size: LmuIconSizes.medium,
          //   color: input.type.color(context.colors),
          // ),
          onTap: () {
            RoomfinderSearchBuildingDetailsRoute(input.id).go(context);
            _recentSearchController.trigger(input);
          },
        );
      },
    );
  }
}

extension RoomfinderSearchEntryTypeExtension on RoomfinderSearchEntryType {
  IconData get icon {
    return switch (this) {
      RoomfinderSearchEntryType.building => LucideIcons.school,
      RoomfinderSearchEntryType.room => LucideIcons.door_closed
    };
  }

  Color color(LmuColors colors) {
    return switch (this) {
      RoomfinderSearchEntryType.building => const Color(0xFF00A0E4),
      RoomfinderSearchEntryType.room => colors.warningColors.textColors.strongColors.base,
    };
  }
}
