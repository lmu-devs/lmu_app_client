import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../services/roomfinder_room_search_service.dart';

class RoomfinderRoomSearchEntry extends SearchEntry {
  const RoomfinderRoomSearchEntry({required super.title, required this.id, super.tags, this.subtitle});

  final String id;
  final String? subtitle;
}

class RoomfinderRoomSearchPage extends StatefulWidget {
  const RoomfinderRoomSearchPage({super.key});

  @override
  State<RoomfinderRoomSearchPage> createState() => _RoomfinderRoomSearchPageState();
}

class _RoomfinderRoomSearchPageState extends State<RoomfinderRoomSearchPage> {
  late final LmuRecentSearchController<RoomfinderRoomSearchEntry> _recentSearchController;
  late final List<RoomfinderRoomSearchEntry> _searchEntries;
  late final List<RoomfinderRoomSearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<RoomfinderRoomSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<RoomfinderRoomSearchEntry>();
    final rooms = _searchService.rooms
        .map((room) => RoomfinderRoomSearchEntry(
              title: room.name,
              id: room.id,
            ))
        .toList();

    _searchEntries = [...rooms];
    _recentSearchEntries = _searchService.recentSearches
        .map((room) => RoomfinderRoomSearchEntry(
              title: room.name,
              id: room.id,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<RoomfinderRoomSearchEntry>(
      searchCutoff: 80,
      searchEntries: _searchEntries,
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) {
        _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.id).toList());
      },
      searchEntryBuilder: (RoomfinderRoomSearchEntry input) {
        return LmuListItem.base(
          title: input.title,
          trailingArea: LmuIcon(
            icon: LucideIcons.external_link,
            size: LmuIconSizes.mediumSmall,
            color: context.colors.neutralColors.textColors.weakColors.base,
          ),
          onTap: () {
            final url = _searchService.getUrl(input.id);
            LmuUrlLauncher.launchWebsite(context: context, url: url).then(
              (_) => _recentSearchController.trigger(input),
            );
          },
        );
      },
    );
  }
}
