import 'dart:convert';
import 'dart:io';

import 'package:core/logging.dart';
import 'package:core/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'api/models/sports_favorites.dart';
import 'errors/sports_generic_exception.dart';

abstract class SportsRepository {
  Future<SportsModel> getSports();

  Future<SportsModel?> getCachedSports();

  Future<void> saveFavoriteSports(List<SportsFavorites> favoriteSports);

  Future<List<SportsFavorites>> getFavoriteSports();

  Future<void> saveRecentSearches(List<String> values);

  Future<List<String>> getRecentSearches();
}

class ConnectedSportsRepository implements SportsRepository {
  final _favoriteSportsKey = 'favoriteSports';
  final _recentSearchesKey = 'sports_recentSearches';
  final _cachedSportsKey = 'sports_cached_data';
  final _cachedTimeStampKey = 'sports_cached_time_stamp';

  final _maxCacheTime = const Duration(days: 2);

  final _apiClient = GetIt.I.get<SportsApiClient>();

  @override
  Future<SportsModel> getSports() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final sportsData = await _apiClient.getSports();
      await prefs.setString(_cachedSportsKey, jsonEncode(sportsData.toJson()));
      await prefs.setInt(_cachedTimeStampKey, DateTime.now().millisecondsSinceEpoch);

      return sportsData;
    } catch (e) {
      if (e is SocketException) throw NoNetworkException();
      throw SportsGenericException();
    }
  }

  @override
  Future<SportsModel?> getCachedSports() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cachedSportsKey);
    final cachedTimeStamp = prefs.getInt(_cachedTimeStampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(_maxCacheTime).isAfter(DateTime.now());
    if (cachedData != null && isCacheValid) {
      try {
        return SportsModel.fromJson(jsonDecode(cachedData));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
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
