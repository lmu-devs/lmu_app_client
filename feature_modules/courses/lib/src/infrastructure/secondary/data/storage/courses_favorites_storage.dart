import 'package:shared_preferences/shared_preferences.dart';

class CoursesFavoritesStorage {
  static const String _favoritesKey = 'courses_favorites';

  Future<List<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteStrings = prefs.getStringList(_favoritesKey) ?? [];
    return favoriteStrings.map((id) => int.parse(id)).toList();
  }

  Future<void> saveFavoriteIds(List<int> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteStrings = favoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList(_favoritesKey, favoriteStrings);
  }
}
