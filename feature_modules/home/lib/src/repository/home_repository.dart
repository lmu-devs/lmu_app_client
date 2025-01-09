import 'api/home_api_client.dart';
import 'api/models/home_model.dart';

abstract class HomeRepository {
  Future<HomeModel> getHomeData();
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
}
