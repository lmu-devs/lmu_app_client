import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/lectures_dto.dart';

class LecturesStorage {
  final _lecturesKey = 'lectures_data_key';
  final _cacheTimestampKey = 'lectures_cache_timestamp';
  
  // Cache expires after 1 hour
  static const Duration _cacheExpiration = Duration(hours: 1);

  Future<void> saveLectures(List<LecturesDto> lectures) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lecturesJson = lectures.map((lecture) => lecture.toJson()).toList();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      
      await prefs.setString(_lecturesKey, jsonEncode(lecturesJson));
      await prefs.setInt(_cacheTimestampKey, timestamp);
    } catch (e) {
      // Storage failed, but don't throw - app can still function
    }
  }

  Future<List<LecturesDto>?> getLectures() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lecturesJson = prefs.getString(_lecturesKey);
      final timestamp = prefs.getInt(_cacheTimestampKey);
      
      if (lecturesJson == null || timestamp == null) return null;
      
      // Check if cache is expired
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(cacheTime) > _cacheExpiration) {
        // Cache expired, delete it
        await deleteLectures();
        return null;
      }
      
      final lecturesList = jsonDecode(lecturesJson) as List;
      return lecturesList.map((lectureMap) => LecturesDto.fromJson(lectureMap)).toList();
    } catch (e) {
      // Cache corrupted, delete it
      await deleteLectures();
      return null;
    }
  }

  Future<void> deleteLectures() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_lecturesKey);
      await prefs.remove(_cacheTimestampKey);
    } catch (e) {
      // Ignore deletion errors
    }
  }
}
