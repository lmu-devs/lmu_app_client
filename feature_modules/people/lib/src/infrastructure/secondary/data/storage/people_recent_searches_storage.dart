import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PeopleRecentSearchesStorage {
  static const String _recentSearchesKey = 'people_recent_searches';
  static const int _maxRecentSearches = 10;

  Future<List<int>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearchesJson = prefs.getStringList(_recentSearchesKey) ?? [];
    
    final List<int> recentSearches = [];
    for (final jsonString in recentSearchesJson) {
      try {
        final int personId = int.parse(jsonString);
        recentSearches.add(personId);
      } catch (e) {
        continue;
      }
    }
    
    return recentSearches;
  }

  Future<void> saveRecentSearches(List<int> recentSearches) async {
    final prefs = await SharedPreferences.getInstance();
    
    final limitedSearches = recentSearches.take(_maxRecentSearches).toList();
    
    final List<String> recentSearchesJson = limitedSearches
        .map((personId) => personId.toString())
        .toList();
    
    await prefs.setStringList(_recentSearchesKey, recentSearchesJson);
  }

  Future<void> addRecentSearch(int personId) async {
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