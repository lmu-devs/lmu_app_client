import 'package:get_it/get_it.dart';

import 'api/api.dart';

abstract class CinemaRepository{
  Future<CinemaModel> getCinema();
}

class ConnectedCinemaRepository implements CinemaRepository{
  final _apiClient = GetIt.I.get<CinemaApiClient>();

  @override
  Future<CinemaModel> getCinema() async {
    return _apiClient.getCinemas();
  }
}