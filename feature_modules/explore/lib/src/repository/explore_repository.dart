import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'api/explore_api_client.dart';
import 'api/models/models.dart';

class ExploreRepository {
  const ExploreRepository({required this.exploreApiClient});

  final ExploreApiClient exploreApiClient;

  final _cacheKey = "roomfinder_cities";

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
      citites = await exploreApiClient.getRoomfinderCities();
      await cacheJsonList(_cacheKey, citites);
    }

    final encodedJson = json.decode(citites) as List<dynamic>;
    final cachedCities = encodedJson.map((json) => RoomfinderCity.fromJson(json as Map<String, dynamic>)).toList();
    return cachedCities;
  }
}
