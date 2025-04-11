import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

abstract class CinemaRepository {
  Future<List<CinemaModel>?> getCinemas();

  Future<List<CinemaModel>?> getCachedCinemas();

  Future<List<ScreeningModel>?> getScreenings();

  Future<List<ScreeningModel>?> getCachedScreenings();

  Future<List<String>?> getLikedScreeningIds();

  Future<void> saveLikedScreeningIds(List<String> ids);

  Future<void> deleteAllLocalData();
}

class ConnectedCinemaRepository implements CinemaRepository {
  ConnectedCinemaRepository({required this.cinemaApiClient});

  final CinemaApiClient cinemaApiClient;

  static const String _cinemasKey = 'cinemas_cache_key';
  static const String _cinemasCacheTimeStampKey = 'cinemas_cache_time_stamp_key';

  static const String _screeningKey = 'screening_cache_key';
  static const String _screeningCacheTimeStampKey = 'screening_cache_time_stamp_key';

  static const String _likedScreeningsIdsKey = 'liked_screenings_ids_key';

  @override
  Future<List<CinemaModel>?> getCinemas({int? id}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final cinemas = await cinemaApiClient.getCinemas(id: id);
      await prefs.setString(_cinemasKey, jsonEncode(cinemas.map((e) => e.toJson()).toList()));
      await prefs.setInt(_cinemasCacheTimeStampKey, DateTime.now().millisecondsSinceEpoch);
      return cinemas;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CinemaModel>?> getCachedCinemas() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cinemasKey);
    final cachedTimeStamp = prefs.getInt(_cinemasCacheTimeStampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(const Duration(days: 14)).isAfter(DateTime.now());
    if (cachedData != null && isCacheValid) {
      final List<dynamic> decodedData = jsonDecode(cachedData);
      return decodedData.map((e) => CinemaModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<ScreeningModel>?> getScreenings() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final screenings = await cinemaApiClient.getScreenings();
      await prefs.setString(_screeningKey, jsonEncode(screenings.map((e) => e.toJson()).toList()));
      await prefs.setInt(_screeningCacheTimeStampKey, DateTime.now().millisecondsSinceEpoch);
      return screenings;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ScreeningModel>?> getCachedScreenings() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_screeningKey);
    final cachedTimeStamp = prefs.getInt(_screeningCacheTimeStampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(const Duration(days: 14)).isAfter(DateTime.now());
    if (cachedData != null && isCacheValid) {
      try {
        final List<dynamic> decodedData = jsonDecode(cachedData);
        return decodedData.map((e) => ScreeningModel.fromJson(e)).toList();
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<List<String>?> getLikedScreeningIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteScreeningIds = prefs.getStringList(_likedScreeningsIdsKey);
    return favoriteScreeningIds;
  }

  @override
  Future<void> saveLikedScreeningIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_likedScreeningsIdsKey, ids);
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedScreeningsIdsKey);
  }
}
