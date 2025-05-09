import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/home_api_client.dart';
import 'api/models/home/home_data.dart';
import 'api/models/links/link_model.dart';

class HomeRepository {
  const HomeRepository({required this.homeApiClient});

  final HomeApiClient homeApiClient;

  static const String _likedLinksKey = 'liked_links_key';
  final String _homeDataKey = 'home_data_key';

  final String _cachedLinksKey = 'cached_links_key';
  final String _cachedLinksTimestampKey = 'cached_links_timestamp_key';

  final _recentLinkSearchesKey = 'links_recentSearches';

  final _maxCacheTime = const Duration(days: 7);

  final String _featuredTilesClosedKey = 'featured_tiles_closed_key';

  Future<HomeData?> getHomeData() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final data = await homeApiClient.getHomeData();
      await prefs.setString(_homeDataKey, jsonEncode(data.toJson()));
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<HomeData?> getCachedHomeData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_homeDataKey);
    if (cachedData != null) {
      try {
        return HomeData.fromJson(jsonDecode(cachedData));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<LinkModel>?> getLinks() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final links = await homeApiClient.getLinks();
      await prefs.setString(_cachedLinksKey, jsonEncode(links));
      await prefs.setInt(_cachedLinksTimestampKey, DateTime.now().millisecondsSinceEpoch);
      return links;
    } catch (e) {
      return null;
    }
  }

  Future<List<LinkModel>?> getCachedLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cachedLinksKey);
    final cachedTimeStamp = prefs.getInt(_cachedLinksTimestampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(_maxCacheTime).isAfter(DateTime.now());
    if (cachedData != null && isCacheValid) {
      try {
        return (jsonDecode(cachedData) as List).map((e) => LinkModel.fromJson(e)).toList();
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<String>?> getLikedLinks() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteLinks = prefs.getStringList(_likedLinksKey);
    return favoriteLinks;
  }

  Future<void> saveLikedLinks(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_likedLinksKey, ids);
  }

  Future<void> saveRecentLinkSearches(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentLinkSearchesKey, values);
  }

  Future<List<String>> getRecentLinkSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentLinkSearches = prefs.getStringList(_recentLinkSearchesKey) ?? [];
    return recentLinkSearches;
  }

  Future<void> updateClosedFeaturedTiles(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final closedTiles = prefs.getStringList(_featuredTilesClosedKey) ?? [];
    if (!closedTiles.contains(id)) {
      closedTiles.add(id);
    }
    await prefs.setStringList(_featuredTilesClosedKey, closedTiles);
  }

  Future<List<String>> getClosedFeaturedTiles() async {
    final prefs = await SharedPreferences.getInstance();
    final closedTiles = prefs.getStringList(_featuredTilesClosedKey) ?? [];
    return closedTiles;
  }

  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedLinksKey);
    await prefs.remove(_homeDataKey);
    await prefs.remove(_cachedLinksKey);
    await prefs.remove(_cachedLinksTimestampKey);
    await prefs.remove(_featuredTilesClosedKey);
  }
}
