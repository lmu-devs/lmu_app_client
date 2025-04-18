import 'dart:async';

import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../repository/api/models/roomfinder_room.dart';
import '../repository/roomfinder_repository.dart';

class RoomfinderRoomSearchService {
  RoomfinderRoomSearchService({required this.buildingPartId, required this.buildingId});

  final String buildingId;
  final String buildingPartId;
  final _roomfinderCubit = GetIt.I.get<RoomfinderCubit>();
  final _roomfinderRepository = GetIt.I.get<RoomfinderRepository>();

  List<RoomfinderRoom> _recentSearches = [];

  List<RoomfinderRoom> get recentSearches => _recentSearches;

  List<RoomfinderRoom> _rooms = [];

  List<RoomfinderRoom> get rooms => _rooms;

  void _updateRecentSearch(List<String> recentSearch) {
    _recentSearches = _rooms.where((room) => recentSearch.contains(room.id)).toList()
      ..sort((a, b) => recentSearch.indexOf(a.id).compareTo(recentSearch.indexOf(b.id)));
  }

  Future<void> init() async {
    final currentState = _roomfinderCubit.state;

    if (currentState is! RoomfinderLoadSuccess) return;

    final buildings = currentState.streets.expand((street) => street.buildings).toList();
    final building = buildings.firstWhere((building) => building.buildingPartId == buildingPartId);
    _rooms = building.floors.expand((floor) => floor.rooms).toList();

    _roomfinderRepository.getRecentRoomSearches(buildingPartId).then((recentSearch) {
      _updateRecentSearch(recentSearch);
    });
  }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    if (_recentSearches.map((room) => room.id).toList() == recentSearch) return;
    _updateRecentSearch(recentSearch);
    await _roomfinderRepository.saveRecentRoomSearches(recentSearch, buildingPartId);
  }

  String getUrl(String roomId) {
    return "https://www.lmu.de/raumfinder/index.html#/building/$buildingId/map?room=$roomId";
  }
}
