import 'dart:convert';
import 'dart:io';

import 'package:core/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/enums/roomfinder_sort_option.dart';
import 'api/models/models.dart';
import 'api/roomfinder_api_client.dart';

class RoomfinderRepository {
  const RoomfinderRepository({required this.roomfinderApiClient});

  final RoomfinderApiClient roomfinderApiClient;

  final _cacheKey = "roomfinder_streets";
  final _favoriteBuildingsKey = "favorite_buildings";
  final _sortOptionKey = "roomfinder_sort_option";
  final _recentSearchesKey = "roomfinder_recentSearches";
  final _recentRoomSearchesBaseKey = "roomfinder_room_recentSearches";

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

  Future<void> deleteCachedJson() async {
    final path = await _getFilePath(_cacheKey);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<List<RoomfinderStreet>> getRoomfinderData() async {
    String? data;

    try {
      data = await getCachedJsonString(_cacheKey);
      if (data == null) {
        data = await roomfinderApiClient.getRoomfinderData();
        await cacheJsonList(_cacheKey, data);
      }
    } catch (e) {
      if (e is SocketException) {
        throw NoNetworkException();
      } else {
        throw Exception("Failed to load roomfinder data: $e");
      }
    }

    final encodedJson = json.decode(data) as List<dynamic>;
    final streets = encodedJson.map((json) => RoomfinderStreet.fromJson(json as Map<String, dynamic>)).toList();
    return streets;
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

  Future<void> saveRecentRoomSearches(List<String> values, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("$_recentRoomSearchesBaseKey$id", values);
  }

  Future<List<String>> getRecentRoomSearches(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList("$_recentRoomSearchesBaseKey$id") ?? [];
    return recentSearches;
  }
}
