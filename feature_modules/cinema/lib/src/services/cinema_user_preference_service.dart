import 'package:core/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../repository/cinema_repository.dart';

class CinemaUserPreferenceService {
  CinemaUserPreferenceService();

  final _cinemaRepository = GetIt.I.get<CinemaRepository>();
  final _appLogger = AppLogger();

  Future init() {
    return Future.wait([
      initLikedScreeningsIds(),
    ]);
  }

  Future reset() {
    return Future.wait([
      _cinemaRepository.deleteAllLocalData(),
      Future.value(_likedScreeningsIdsNotifier.value = []),
    ]);
  }

  final _likedScreeningsIdsNotifier = ValueNotifier<List<String>>([]);

  ValueNotifier<List<String>> get likedScreeningsIdsNotifier => _likedScreeningsIdsNotifier;

  Future<void> initLikedScreeningsIds() async {
    final likedScreeningIds = await _cinemaRepository.getLikedScreeningIds() ?? [];
    _likedScreeningsIdsNotifier.value = likedScreeningIds;
    _appLogger.logMessage('[ScreeningsUserPreferenceService]: Local liked screening ids: $likedScreeningIds');
  }

  Future<void> toggleLikedScreeningId(String id) async {
    final likedScreeningIds = List<String>.from(_likedScreeningsIdsNotifier.value);

    if (likedScreeningIds.contains(id)) {
      likedScreeningIds.remove(id);
    } else {
      likedScreeningIds.insert(0, id);
    }

    _likedScreeningsIdsNotifier.value = likedScreeningIds;
    await _cinemaRepository.saveLikedScreeningIds(likedScreeningIds);
  }
}
