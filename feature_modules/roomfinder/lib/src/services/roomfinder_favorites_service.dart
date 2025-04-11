import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../repository/roomfinder_repository.dart';

class RoomfinderFavoritesService {
  final _roomfinderRepo = GetIt.I.get<RoomfinderRepository>();

  final ValueNotifier<List<String>> _favoriteBuildingIdsNotifier = ValueNotifier([]);

  ValueNotifier<List<String>> get favoriteBuildingIdsNotifier => _favoriteBuildingIdsNotifier;

  StreamSubscription? _cubitSubscription;

  void init() async {
    final favoriteBuildingIds = await _roomfinderRepo.getFavoriteBuildings();
    _favoriteBuildingIdsNotifier.value = favoriteBuildingIds;
  }

  Future<void> toggleFavorite(String buildingId) async {
    final currentFavorites = List.of(_favoriteBuildingIdsNotifier.value);
    final isAlreadyFavorite = currentFavorites.contains(buildingId);
    if (isAlreadyFavorite) {
      currentFavorites.remove(buildingId);
    } else {
      currentFavorites.add(buildingId);
    }
    _favoriteBuildingIdsNotifier.value = currentFavorites;
    await _roomfinderRepo.saveFavoriteBuildings(currentFavorites);
  }

  void dispose() {
    _cubitSubscription?.cancel();
    _favoriteBuildingIdsNotifier.dispose();
  }
}
