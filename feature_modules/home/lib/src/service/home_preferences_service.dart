import 'package:core/logging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/home_repository.dart';

class HomePreferencesService {
  HomePreferencesService();

  final _homeRepository = GetIt.I.get<HomeRepository>();
  final _appLogger = AppLogger();

  final _likedLinksNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get likedLinksNotifier => _likedLinksNotifier;

  final ValueNotifier<bool> _isFeaturedClosedNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> get isFeaturedClosedNotifier => _isFeaturedClosedNotifier;

  Future init() {
    return Future.wait([
      initLikedLinks(),
    ]);
  }

  Future<void> setFeaturedClosed(String id) async {
    _isFeaturedClosedNotifier.value = true;
    await _homeRepository.updateClosedFeaturedTiles(id);
  }

  Future<void> initLikedLinks() async {
    final likedLinks = await _homeRepository.getLikedLinks() ?? [];
    _likedLinksNotifier.value = likedLinks;
    _appLogger.logMessage('[HomePreferenceService]: Local liked links: $likedLinks');
  }

  Future<void> toggleLikedLinks(String id) async {
    final likedLinks = List<String>.from(_likedLinksNotifier.value);

    if (likedLinks.contains(id)) {
      likedLinks.remove(id);
    } else {
      likedLinks.insert(0, id);
    }

    _likedLinksNotifier.value = likedLinks;
    await _homeRepository.saveLikedLinks(likedLinks);
  }

  Future<void> updateLikedLinks(List<String> likedLinks) async {
    _likedLinksNotifier.value = likedLinks;
    await _homeRepository.saveLikedLinks(likedLinks);
  }

  Future reset() {
    return Future.wait([
      _homeRepository.deleteAllLocalData(),
      Future.value(_likedLinksNotifier.value = []),
    ]);
  }
}
