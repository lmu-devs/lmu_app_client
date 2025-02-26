import 'package:core/logging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/home_repository.dart';

class HomePreferencesService {
  HomePreferencesService();

  final _homeRepository = GetIt.I.get<HomeRepository>();
  final _appLogger = AppLogger();

  final _tuitionKey = 'tuitionPayed';

  final _likedLinksNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get likedLinksNotifier => _likedLinksNotifier;

  final ValueNotifier<bool> _tuitionPayed = ValueNotifier<bool>(false);
  ValueNotifier<bool> get tuitionPayed => _tuitionPayed;

  Future init() {
    return Future.wait([
      initTuition(),
      initLikedLinks(),
    ]);
  }

  Future reset() {
    return Future.wait([
      _homeRepository.deleteAllLocalData(),
      Future.value(_likedLinksNotifier.value = []),
    ]);
  }

  Future<void> initTuition() async {
    final prefs = await SharedPreferences.getInstance();
    _tuitionPayed.value = prefs.getBool(_tuitionKey) ?? false;
  }

  Future<void> setTuitionPayed(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tuitionKey, value);
    _tuitionPayed.value = value;
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
}
