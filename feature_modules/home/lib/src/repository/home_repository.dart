import 'api/home_api_client.dart';
import 'api/models/home_model.dart';
import 'api/models/links/link_model.dart';

abstract class HomeRepository {
  Future<HomeModel> getHomeData();

  Future<List<LinkModel>> getLinks();
}

class ConnectedHomeRepository implements HomeRepository {
  ConnectedHomeRepository({
    required this.homeApiClient,
  });

  final HomeApiClient homeApiClient;

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
}
