import 'dart:async';

import 'package:core/utils.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../repository/api/models/roomfinder_building.dart';
import '../repository/api/models/roomfinder_room.dart';
import '../repository/roomfinder_repository.dart';

class RoomfinderSearchService {
  final _roomfinderCubit = GetIt.I.get<RoomfinderCubit>();
  final _roomfinderRepository = GetIt.I.get<RoomfinderRepository>();

  List<RoomfinderBuilding> _recentSearches = [];

  List<RoomfinderBuilding> get recentSearches => _recentSearches;

  List<RoomfinderBuilding> _buildings = [];

  StreamSubscription? _cubitSubscription;

  List<RoomfinderBuilding> get buildings => _buildings;
  List<RoomfinderRoom> get rooms => _buildings.expand((part) => part.floors).expand((floor) => floor.rooms).toList();

  void _updateRecentSearch(List<String> recentSearch) {
    _recentSearches = _buildings.where((building) => recentSearch.contains(building.buildingPartId)).toList()
      ..sort((a, b) => recentSearch.indexOf(a.buildingPartId).compareTo(recentSearch.indexOf(b.buildingPartId)));
  }

  void init() {
    _cubitSubscription = _roomfinderCubit.stream.withInitialValue(_roomfinderCubit.state).listen((state) {
      if (state is RoomfinderLoadSuccess) {
        _buildings = state.streets.expand((street) => street.buildings).toList();
        _roomfinderRepository.getRecentSearches().then((recentSearch) {
          _updateRecentSearch(recentSearch);
        });
      }
    });
  }

  void dispose() {
    _cubitSubscription?.cancel();
  }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    if (_recentSearches.map((building) => building.buildingPartId).toList() == recentSearch) return;
    _updateRecentSearch(recentSearch);
    await _roomfinderRepository.saveRecentSearches(recentSearch);
  }
}
