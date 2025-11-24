import 'package:shared_preferences/shared_preferences.dart';

class CalendarRecentSearchesStorage {
  static const String _recentSearchesKey = 'calendar_recent_searches';
  static const int _maxRecentSearches = 10;

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  Future<void> saveRecentSearches(List<String> recentSearches) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, recentSearches);
  }

  Future<void> addRecentSearch(String calendarEntryId) async {
    final currentSearches = await getRecentSearches();

    currentSearches.removeWhere((id) => id == calendarEntryId);
    currentSearches.insert(0, calendarEntryId);

    if (currentSearches.length > _maxRecentSearches) {
      currentSearches.removeRange(_maxRecentSearches, currentSearches.length);
    }

    await saveRecentSearches(currentSearches);
  }

  Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentSearchesKey);
  }
}
