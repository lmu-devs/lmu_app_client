import 'package:shared_preferences/shared_preferences.dart';

class CoursesRecentSearchesStorage {
  static const String _recentSearchesKey = 'courses_recent_searches';
  static const int _maxRecentSearches = 6;

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  Future<void> saveRecentSearches(List<String> recentSearches) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, recentSearches);
  }

  Future<void> addRecentSearch(String personId) async {
    final currentSearches = await getRecentSearches();

    currentSearches.removeWhere((id) => id == personId);
    currentSearches.insert(0, personId);

    await saveRecentSearches(currentSearches);
  }

  Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentSearchesKey);
  }
}
