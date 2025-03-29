import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/enums/roomfinder_sort_option.dart';
import 'api/models/models.dart';
import 'api/roomfinder_api_client.dart';

class RoomfinderRepository {
  const RoomfinderRepository({required this.roomfinderApiClient});

  final RoomfinderApiClient roomfinderApiClient;

  final _cacheKey = "roomfinder_cities";
  final _favoriteBuildingsKey = "favorite_buildings";
  final _sortOptionKey = "roomfinder_sort_option";
  final _recentSearchesKey = "roomfinder_recentSearches";

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$filename.json';
  }

  Future<void> cacheJsonList(String filename, String jsonString) async {
    final path = await _getFilePath(filename);
    final file = File(path);

    await file.writeAsString(jsonString);
  }

  Future<String?> getCachedJsonString(String filename) async {
    final path = await _getFilePath(filename);
    final file = File(path);

    if (!await file.exists()) return null;

    final jsonString = await file.readAsString();

    return jsonString;
  }

  Future<List<RoomfinderCity>> getRoomfinderCities() async {
    String? citites;
    citites = await getCachedJsonString(_cacheKey);

    if (citites == null) {
      citites = await roomfinderApiClient.getRoomfinderCities();
      await cacheJsonList(_cacheKey, citites);
    }

    final encodedJson = json.decode(citites) as List<dynamic>;
    final cachedCities = encodedJson.map((json) => RoomfinderCity.fromJson(json as Map<String, dynamic>)).toList();
    return cachedCities;
  }

  Future<void> saveFavoriteBuildings(List<String> favoriteBuildingIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteBuildingsKey, favoriteBuildingIds);
  }

  Future<List<String>> getFavoriteBuildings() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteBuildingIds = prefs.getStringList(_favoriteBuildingsKey) ?? [];
    return favoriteBuildingIds;
  }

  Future<void> saveSortOption(RoomfinderSortOption sortOption) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sortOptionKey, sortOption.index);
  }

  Future<RoomfinderSortOption?> getSortOption() async {
    final prefs = await SharedPreferences.getInstance();
    final sortOptionIndex = prefs.getInt(_sortOptionKey);
    if (sortOptionIndex == null) return null;
    return RoomfinderSortOption.values[sortOptionIndex];
  }

  Future<void> saveRecentSearches(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, values);
  }

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_recentSearchesKey) ?? [];
    return recentSearches;
  }
}
