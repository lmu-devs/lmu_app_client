import 'api/api.dart';
import 'api/models/screening_model.dart';

abstract class CinemaRepository{
  Future<List<CinemaModel>> getCinemas();

  Future<List<ScreeningModel>> getScreenings();
}

class ConnectedCinemaRepository implements CinemaRepository{
  ConnectedCinemaRepository({
    required this.cinemaApiClient,
  });

  final CinemaApiClient cinemaApiClient;

  @override
  Future<List<CinemaModel>> getCinemas({int? id}) async {
    try {
      final cinemas = await cinemaApiClient.getCinemas(id: id);
      return cinemas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ScreeningModel>> getScreenings() async {
    try {
      final screenings = await cinemaApiClient.getScreenings();
      return screenings;
    } catch (e) {
      rethrow;
    }
  }
}
