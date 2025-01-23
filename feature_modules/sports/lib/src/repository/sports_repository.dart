import 'package:get_it/get_it.dart';

import 'api/api.dart';

abstract class SportsRepository {
  Future<List<SportsModel>> getSports();
}

class ConnectedSportsRepository implements SportsRepository {
  final _apiClient = GetIt.I.get<SportsApiClient>();

  @override
  Future<List<SportsModel>> getSports() async {
    return _apiClient.getSports();
  }
}
