import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

abstract class CinemaRepository{
  Future<List<CinemaModel>> getCinemas();

  Future<List<ScreeningModel>> getScreenings();

  Future<List<String>?> getLikedScreeningIds();

  Future<void> saveLikedScreeningIds(List<String> ids);

  Future<void> deleteAllLocalData();
}

class ConnectedCinemaRepository implements CinemaRepository{
  ConnectedCinemaRepository({
    required this.cinemaApiClient,
  });

  final CinemaApiClient cinemaApiClient;

  static const String _likedScreeningsIdsKey = 'liked_screenings_ids_key';

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

  @override
  Future<List<String>?> getLikedScreeningIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteScreeningIds = prefs.getStringList(_likedScreeningsIdsKey);
    return favoriteScreeningIds;
  }

  @override
  Future<void> saveLikedScreeningIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_likedScreeningsIdsKey, ids);
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedScreeningsIdsKey);
  }
}
