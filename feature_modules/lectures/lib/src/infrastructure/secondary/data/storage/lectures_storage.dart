import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/exception/lectures_generic_exception.dart';
import '../dto/lecture_dto.dart';

class LecturesStorage {
  final _lecturesKey = 'lectures_data_key';
  final _lecturesTimestampKey = 'lectures_timestamp_key';
  final _favoritesKey = 'favorite_lectures_key';

  // Cache expires after 1 hour
  static const Duration _cacheExpiration = Duration(hours: 1);

  // Cache lectures by faculty
  Future<void> saveLecturesByFaculty(int facultyId, List<LectureDto> lectures) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${_lecturesKey}_$facultyId';
      final timestampKey = '${_lecturesTimestampKey}_$facultyId';
      final lecturesJson = lectures.map((lecture) => lecture.toJson()).toList();

      await prefs.setString(key, jsonEncode(lecturesJson));
      await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Log storage error but don't throw - caching is not critical
      debugPrint('Failed to save lectures to cache: $e');
      throw LecturesGenericException('Failed to save lectures to cache: ${e.toString()}');
    }
  }

  Future<List<LectureDto>?> getLecturesByFaculty(int facultyId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${_lecturesKey}_$facultyId';
      final timestampKey = '${_lecturesTimestampKey}_$facultyId';

      final lecturesJson = prefs.getString(key);
      final timestamp = prefs.getInt(timestampKey);

      if (lecturesJson == null || timestamp == null) return null;

      // Check if cache is expired
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      if (now.difference(cacheTime) > _cacheExpiration) {
        return null;
      }

      try {
        final List<dynamic> lecturesList = jsonDecode(lecturesJson);
        return lecturesList.map((json) => LectureDto.fromJson(json)).toList();
      } catch (e) {
        // Cache data is corrupted, return null to force fresh fetch
        debugPrint('Cache data corrupted for faculty $facultyId: $e');
        return null;
      }
    } catch (e) {
      // Storage error, return null to force fresh fetch
      debugPrint('Storage error for faculty $facultyId: $e');
      return null;
    }
  }

  Future<void> deleteLecturesByFaculty(int facultyId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_lecturesKey}_$facultyId';
    final timestampKey = '${_lecturesTimestampKey}_$facultyId';
    await prefs.remove(key);
    await prefs.remove(timestampKey);
  }

  // Favorites management
  Future<void> saveFavoriteIds(Set<String> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favoriteIds.toList());
  }

  Future<Set<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList(_favoritesKey);
    return favoriteIds?.toSet() ?? <String>{};
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs
        .getKeys()
        .where((key) => key.startsWith(_lecturesKey) || key.startsWith(_lecturesTimestampKey) || key == _favoritesKey);
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}
