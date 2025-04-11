import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/home_api_client.dart';
import 'api/models/benefits/benefit_model.dart';
import 'api/models/home/home_data.dart';
import 'api/models/links/link_model.dart';

abstract class HomeRepository {
  Future<HomeData?> getHomeData();

  Future<HomeData?> getCachedHomeData();

  Future<List<LinkModel>?> getLinks();

  Future<List<LinkModel>?> getCachedLinks();

  Future<List<String>?> getLikedLinks();

  Future<void> saveLikedLinks(List<String> ids);

  Future<void> deleteAllLocalData();

  Future<List<BenefitModel>?> getBenefits();

  Future<List<BenefitModel>?> getCachedBenefits();
}

class ConnectedHomeRepository implements HomeRepository {
  const ConnectedHomeRepository({required this.homeApiClient});

  final HomeApiClient homeApiClient;

  static const String _likedLinksKey = 'liked_links_key';
  final String _homeDataKey = 'home_data_key';

  final String _cachedLinksKey = 'cached_links_key';
  final String _cachedLinksTimestampKey = 'cached_links_timestamp_key';

  final String _cachedBenefitsKey = 'cached_benefits_key';
  final String _cachedBenefitsTimestampKey = 'cached_benefits_timestamp_key';
  final _maxCacheTime = const Duration(days: 7);

  @override
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

  @override
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

  @override
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

  @override
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

  @override
  Future<List<String>?> getLikedLinks() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteLinks = prefs.getStringList(_likedLinksKey);
    return favoriteLinks;
  }

  @override
  Future<void> saveLikedLinks(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_likedLinksKey, ids);
  }

  @override
  Future<List<BenefitModel>?> getBenefits() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final benefits = await homeApiClient.getBenefits();
      await prefs.setString(_cachedBenefitsKey, jsonEncode(benefits));
      await prefs.setInt(_cachedBenefitsTimestampKey, DateTime.now().millisecondsSinceEpoch);
      return benefits;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<BenefitModel>?> getCachedBenefits() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cachedBenefitsKey);
    final cachedTimeStamp = prefs.getInt(_cachedBenefitsTimestampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(_maxCacheTime).isAfter(DateTime.now());
    if (cachedData != null && isCacheValid) {
      try {
        return (jsonDecode(cachedData) as List).map((e) => BenefitModel.fromJson(e)).toList();
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedLinksKey);
    await prefs.remove(_homeDataKey);
    await prefs.remove(_cachedLinksKey);
    await prefs.remove(_cachedLinksTimestampKey);
    await prefs.remove(_cachedBenefitsKey);
    await prefs.remove(_cachedBenefitsTimestampKey);
  }
}
