import 'dart:convert';

import 'package:core/logging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'api/models/sports_favorites.dart';

abstract class SportsRepository {
  Future<SportsModel> getSports();

  Future<void> saveFavoriteSports(List<SportsFavorites> favoriteSports);

  Future<List<SportsFavorites>> getFavoriteSports();

  Future<void> saveRecentSearches(List<String> values);

  Future<List<String>> getRecentSearches();
}

class ConnectedSportsRepository implements SportsRepository {
  final _favoriteSportsKey = 'favoriteSports';
  final _recentSearchesKey = 'sports_recentSearches';

  final _apiClient = GetIt.I.get<SportsApiClient>();

  @override
  Future<SportsModel> getSports() async {
    return _apiClient.getSports();
  }

  @override
  Future<void> saveFavoriteSports(List<SportsFavorites> favoriteSports) async {
    final prefs = await SharedPreferences.getInstance();

    final encodedData = jsonEncode(favoriteSports.map((e) => e.toJson()).toList());
    await prefs.setString(_favoriteSportsKey, encodedData);

    AppLogger().logMessage('[SportsRepository]: Saved favorite sports $favoriteSports');
  }

  @override
  Future<List<SportsFavorites>> getFavoriteSports() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoriteSportsKey);

    if (jsonString == null) return [];

    final List<dynamic> decodedList = jsonDecode(jsonString);
    return decodedList.map((e) => SportsFavorites.fromJson(e)).toList();
  }

  @override
  Future<void> saveRecentSearches(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, values);
  }

  @override
  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_recentSearchesKey) ?? [];
    return recentSearches;
  }
}
