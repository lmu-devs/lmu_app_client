import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/clubs_dto.dart';

class ClubsStorage {
  final _clubsCacheKey = 'clubs_cache';
  final _clubsCacheTimeKey = 'clubs_cache_time';
  final _clubsCacheTime = const Duration(days: 14);

  Future<void> saveClubs(ClubsDto clubs) async {
    final prefs = await SharedPreferences.getInstance();
    final clubsJson = jsonEncode(clubs.toJson());
    await prefs.setString(_clubsCacheKey, clubsJson);
    await prefs.setInt(_clubsCacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<ClubsDto?> getClubs() async {
    final prefs = await SharedPreferences.getInstance();
    final clubsJson = prefs.getString(_clubsCacheKey);
    if (clubsJson == null) return null;
    final cacheTime = prefs.getInt(_clubsCacheTimeKey);
    final isCacheValid = cacheTime != null && _isCacheValid(cacheTime);
    if (!isCacheValid) {
      prefs.remove(_clubsCacheKey);
      return null;
    }

    try {
      final clubsMap = jsonDecode(clubsJson) as Map<String, dynamic>;
      return ClubsDto.fromJson(clubsMap);
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteClubs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_clubsCacheKey);
  }

  bool _isCacheValid(int? cacheTime) {
    if (cacheTime == null) return false;
    final cacheDate = DateTime.fromMillisecondsSinceEpoch(cacheTime);
    return cacheDate.add(_clubsCacheTime).isAfter(DateTime.now());
  }
}
