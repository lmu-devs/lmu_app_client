import 'package:shared_preferences/shared_preferences.dart';

class ExploreRepository {
  final _recentSearchesKey = 'explore_recentSearches';
  Future<void> saveRecentSearches(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, values);
  }

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_recentSearchesKey) ?? [];
    return recentSearches;
  }
}
