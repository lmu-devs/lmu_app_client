import '../models/club_category.dart';

abstract class ClubsRepositoryInterface {
  Future<List<ClubCategory>> getClubs();

  Future<List<ClubCategory>?> getCachedClubs();

  Future<void> deleteCachedClubs();
}
