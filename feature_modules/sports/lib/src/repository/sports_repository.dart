import 'dart:convert';

import 'package:core/logging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

abstract class SportsRepository {
  Future<SportsModel> getSports();

  Future<void> saveFavoriteSports(List<Map<String, List<String>>> favoriteSports);

  Future<List<Map<String, List<String>>>> getFavoriteSports();
}

class ConnectedSportsRepository implements SportsRepository {
  final _favoriteSportsKey = 'favoriteSports';
  final _apiClient = GetIt.I.get<SportsApiClient>();

  @override
  Future<SportsModel> getSports() async {
    return _apiClient.getSports();
  }

  @override
  Future<void> saveFavoriteSports(List<Map<String, List<String>>> favoriteSports) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(favoriteSports);
    await prefs.setString(_favoriteSportsKey, encodedData);

    AppLogger().logMessage('[SportsRepository]: Saved favorite sports $favoriteSports');
  }

  @override
  Future<List<Map<String, List<String>>>> getFavoriteSports() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_favoriteSportsKey);

    final jsonString = prefs.getString(_favoriteSportsKey);

    if (jsonString == null) return [];

    final decodedList = jsonDecode(jsonString);

    return decodedList.map((map) {
      return (map as Map<String, dynamic>).map((key, value) {
        return MapEntry(key, List<String>.from(value));
      });
    }).toList();
  }
}
