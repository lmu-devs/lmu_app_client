import 'package:core/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../repository/libraries_repository.dart';

class LibrariesUserPreferenceService {
  LibrariesUserPreferenceService();

  final _librariesRepository = GetIt.I.get<LibrariesRepository>();
  final _appLogger = AppLogger();

  Future init() {
    return Future.wait([
      //initLikedScreeningsIds(),
    ]);
  }

  Future reset() {
    return Future.wait([
      //_cinemaRepository.deleteAllLocalData(),
      //Future.value(_likedScreeningsIdsNotifier.value = []),
    ]);
  }
}
