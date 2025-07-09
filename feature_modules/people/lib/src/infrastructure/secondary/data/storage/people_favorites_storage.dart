import 'package:shared_preferences/shared_preferences.dart';

class PeopleFavoritesStorage {
  static const String _favoritesKey = 'people_favorites';

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

  Future<void> addFavorite(int personId) async {
    final currentFavorites = await getFavoriteIds();
    if (!currentFavorites.contains(personId)) {
      currentFavorites.add(personId);
      await saveFavoriteIds(currentFavorites);
    }
  }

  Future<void> removeFavorite(int personId) async {
    final currentFavorites = await getFavoriteIds();
    currentFavorites.remove(personId);
    await saveFavoriteIds(currentFavorites);
  }

  Future<bool> isFavorite(int personId) async {
    final favoriteIds = await getFavoriteIds();
    return favoriteIds.contains(personId);
  }
} 