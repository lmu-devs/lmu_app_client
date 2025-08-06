import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PeopleRecentSearchesStorage {
  static const String _recentSearchesKey = 'people_recent_searches';
  static const int _maxRecentSearches = 10;

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  Future<void> saveRecentSearches(List<String> recentSearches) async {
    final prefs = await SharedPreferences.getInstance();
    
    final limitedSearches = recentSearches.take(_maxRecentSearches).toList();
    
    await prefs.setStringList(_recentSearchesKey, limitedSearches);
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