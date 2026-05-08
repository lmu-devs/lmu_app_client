import 'dart:io';

import 'package:core/utils.dart';

import '../../../domain/exception/clubs_generic_exception.dart';
import '../../../domain/interface/clubs_repository_interface.dart';
import '../../../domain/models/club_category.dart';
import '../data/api/clubs_api_client.dart';
import '../data/dto/clubs_mapper.dart';
import '../data/storage/clubs_storage.dart';

class ClubsRepository implements ClubsRepositoryInterface {
  const ClubsRepository(this._apiClient, this._storage);
  final ClubsApiClient _apiClient;
  final ClubsStorage _storage;

  @override
  Future<List<ClubCategory>> getClubs() async {
    try {
      final response = await _apiClient.getClubs();
      _storage.saveClubs(response);
      return ClubsMapper.mapToDomain(response);
    } catch (e) {
      if (e is SocketException) throw NoNetworkException();
      throw ClubsGenericException();
    }
  }

  @override
  Future<List<ClubCategory>?> getCachedClubs() async {
    final cachedClubs = await _storage.getClubs();
    if (cachedClubs == null) return null;
    try {
      return ClubsMapper.mapToDomain(cachedClubs);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> deleteCachedClubs() async {
    await _storage.deleteClubs();
  }
}
