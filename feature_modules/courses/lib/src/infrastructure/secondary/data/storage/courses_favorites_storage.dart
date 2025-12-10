import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesFavoritesStorage {
  static const String _favoritesKey = 'courses_favorites_map_v1';

  Future<Map<int, List<int>>> getFavoritesMap() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_favoritesKey);

    if (jsonString == null) {
      return {};
    }

    try {
      final Map<String, dynamic> decoded = jsonDecode(jsonString);
      final Map<int, List<int>> result = {};

      decoded.forEach((key, value) {
        final facultyId = int.tryParse(key);
        if (facultyId != null && value is List) {
          result[facultyId] = value.map((e) => e as int).toList();
        }
      });

      return result;
    } catch (e) {
      return {};
    }
  }

  Future<void> saveFavoritesMap(Map<int, List<int>> favoritesMap) async {
    final prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> jsonMap = favoritesMap.map(
          (key, value) => MapEntry(key.toString(), value),
    );

    final String jsonString = jsonEncode(jsonMap);
    await prefs.setString(_favoritesKey, jsonString);
  }
}
