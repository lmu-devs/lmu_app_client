import 'package:shared_preferences/shared_preferences.dart';

import 'api/home_api_client.dart';
import 'api/models/benefits/benefit_model.dart';
import 'api/models/home_model.dart';
import 'api/models/links/link_model.dart';

abstract class HomeRepository {
  Future<HomeModel> getHomeData();

  Future<List<LinkModel>> getLinks();

  Future<List<String>?> getLikedLinks();

  Future<void> saveLikedLinks(List<String> ids);

  Future<void> deleteAllLocalData();

  Future<List<BenefitModel>> getBenefits();
}

class ConnectedHomeRepository implements HomeRepository {
  ConnectedHomeRepository({
    required this.homeApiClient,
  });

  final HomeApiClient homeApiClient;

  static const String _likedLinksKey = 'liked_links_key';

  @override
  Future<HomeModel> getHomeData() async {
    try {
      return await homeApiClient.getHomeData();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LinkModel>> getLinks() async {
    try {
      final links = await homeApiClient.getLinks();
      return links;
    } catch (e) {
      rethrow;
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
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedLinksKey);
  }

  @override
  Future<List<BenefitModel>> getBenefits() async {
    try {
      final benefits = await homeApiClient.getBenefits();
      return benefits;
    } catch (e) {
      rethrow;
    }
  }
}
