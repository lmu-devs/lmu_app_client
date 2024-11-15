import 'package:flutter/foundation.dart';

import '../repository/api/models/user_preferences/user_preferences.dart';
import '../repository/mensa_repository.dart';

class MensaUserPreferencesService {
  MensaUserPreferencesService({
    required MensaRepository mensaRepository,
  }) : _mensaRepository = mensaRepository;

  Future init() {
    return Future.wait([
      getSortOption(),
      getFavoriteMensaIds(),
    ]);
  }

  final MensaRepository _mensaRepository;

  var _initialSortOption = SortOption.alphabetically;
  SortOption get initialSortOption => _initialSortOption;

  final _favoriteMensaIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteMensaIdsNotifier => _favoriteMensaIdsNotifier;

  Future<void> getFavoriteMensaIds() async {
    final favoriteMensaIds = await _mensaRepository.getFavoriteMensaIds();

    if (favoriteMensaIds != null) {
      _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    }
  }

  Future<void> toggleFavoriteMensaId(String mensaId) async {
    final favoriteMensaIds = List<String>.from(_favoriteMensaIdsNotifier.value);

    if (favoriteMensaIds.contains(mensaId)) {
      favoriteMensaIds.remove(mensaId);
    } else {
      favoriteMensaIds.insert(0, mensaId);
    }

    await _updateFavoriteMensaIds(favoriteMensaIds);
  }

  Future<void> _updateFavoriteMensaIds(List<String> favoriteMensaIds) async {
    _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    await _mensaRepository.updateFavoriteMensaIds(favoriteMensaIds);
  }

  Future<void> getSortOption() async {
    final loadedSortOption = await _mensaRepository.getSortOption();

    if (loadedSortOption != null) {
      _initialSortOption = loadedSortOption;
    }
  }

  Future<void> updateSortOption(SortOption sortOption) async {
    await _mensaRepository.setSortOption(sortOption);
  }

  final _favoriteDishIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteDishIdsNotifier => _favoriteDishIdsNotifier;

  Future<void> getFavoriteDishIds() async {
    final favoriteDishIds = await _mensaRepository.getFavoriteDishIds();

    if (favoriteDishIds != null) {
      _favoriteDishIdsNotifier.value = favoriteDishIds;
    }
  }

  Future<void> toggleFavoriteDishId(String dishId) async {
    final favoriteDishIds = List<String>.from(_favoriteDishIdsNotifier.value);

    if (favoriteDishIds.contains(dishId)) {
      favoriteDishIds.remove(dishId);
    } else {
      favoriteDishIds.insert(0, dishId);
    }

    await _updateFavoriteDishIds(favoriteDishIds);
  }

  Future<void> _updateFavoriteDishIds(List<String> favoriteDishIds) async {
    _favoriteDishIdsNotifier.value = favoriteDishIds;
    await _mensaRepository.updateFavoriteDishIds(favoriteDishIds);
  }
}
