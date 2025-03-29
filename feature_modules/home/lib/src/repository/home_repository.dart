import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/home_api_client.dart';
import 'api/models/benefits/benefit_model.dart';
import 'api/models/home/home_data.dart';
import 'api/models/links/link_model.dart';

abstract class HomeRepository {
  Future<HomeData> getHomeData();

  Future<List<LinkModel>> getLinks();

  Future<List<String>?> getLikedLinks();

  Future<void> saveLikedLinks(List<String> ids);

  Future<void> deleteAllLocalData();

  Future<List<BenefitModel>> getBenefits();
}

class ConnectedHomeRepository implements HomeRepository {
  const ConnectedHomeRepository({required this.homeApiClient});

  final HomeApiClient homeApiClient;

  static const String _likedLinksKey = 'liked_links_key';
  final String _homeDataKey = 'home_data_key';

  @override
  Future<HomeData> getHomeData() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final data = await homeApiClient.getHomeData();
      await prefs.setString(_homeDataKey, jsonEncode(data.toJson()));
      return data;
    } catch (e) {
      final cachedData = prefs.getString(_homeDataKey);
      if (cachedData != null) {
        return HomeData.fromJson(jsonDecode(cachedData));
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<List<LinkModel>> getLinks() async {
    return await homeApiClient.getLinks();
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
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedLinksKey);
  }

  @override
  Future<List<BenefitModel>> getBenefits() async {
    return await homeApiClient.getBenefits();
  }
}
