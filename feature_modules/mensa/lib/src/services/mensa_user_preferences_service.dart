import 'package:core/logging.dart';
import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../repository/api/models/user_preferences/user_preferences.dart';
import '../repository/mensa_repository.dart';

class MensaUserPreferencesService {
  MensaUserPreferencesService();

  final _mensaRepository = GetIt.I.get<MensaRepository>();
  final _appLogger = AppLogger();

  Future init() {
    return Future.wait([
      initFavoriteMensaIds(),
      initFavoriteDishIds(),
      getSortOption(),
    ]);
  }

  Future reset() {
    _appLogger.logMessage('[MensaUserPreferencesService]: Resetting user preferences');
    return Future.wait([
      _mensaRepository.deleteAllLocalData(),
      updateSortOption(SortOption.rating),
      Future.value(_favoriteMensaIdsNotifier.value = []),
      Future.value(_favoriteDishIdsNotifier.value = []),
    ]);
  }

  SortOption _initialSortOption = SortOption.rating;
  SortOption get initialSortOption => _initialSortOption;

  final _favoriteMensaIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteMensaIdsNotifier => _favoriteMensaIdsNotifier;

  final _favoriteDishIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteDishIdsNotifier => _favoriteDishIdsNotifier;

  Future<void> initFavoriteMensaIds() async {
    final favoriteMensaIds = await _mensaRepository.getFavoriteMensaIds() ?? [];
    _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    _appLogger.logMessage('[MensaUserPreferencesService]: Local favorite mensa ids: $favoriteMensaIds');

    final mensaCubit = GetIt.I<MensaCubit>();
    final mensaCubitState = mensaCubit.state;
    mensaCubit.stream.withInitialValue(mensaCubitState).listen((state) async {
      if (state is MensaLoadSuccess) {
        final retrievedFavoriteMensaIds =
            state.mensaModels.where((mensa) => mensa.ratingModel.isLiked).map((mensa) => mensa.canteenId).toList();
        _appLogger
            .logMessage('[MensaUserPreferencesService]: Retrieved favorite mensa ids: $retrievedFavoriteMensaIds');

        final unsyncedFavoriteMensaIds =
            favoriteMensaIds.where((id) => !retrievedFavoriteMensaIds.contains(id)).toList();

        final unsyncedUnfavoriteMensaIds =
            retrievedFavoriteMensaIds.where((id) => !favoriteMensaIds.contains(id)).toList();

        final missingSyncMensaIds = unsyncedFavoriteMensaIds + unsyncedUnfavoriteMensaIds;
        for (final missingSyncMensaId in missingSyncMensaIds) {
          await _mensaRepository.toggleFavoriteMensaId(missingSyncMensaId);
        }
      }
    });
  }

  Future<void> updateFavoriteMensaOrder(List<String> favoriteMensaIds) async {
    _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    await _mensaRepository.saveFavoriteMensaIds(favoriteMensaIds);
  }

  Future<void> toggleFavoriteMensaId(String mensaId) async {
    final favoriteMensaIds = List<String>.from(_favoriteMensaIdsNotifier.value);

    if (favoriteMensaIds.contains(mensaId)) {
      favoriteMensaIds.remove(mensaId);
    } else {
      favoriteMensaIds.insert(favoriteMensaIds.length, mensaId);
    }

    _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    await _mensaRepository.saveFavoriteMensaIds(favoriteMensaIds);

    await _mensaRepository.toggleFavoriteMensaId(mensaId);
  }

  Future<void> initFavoriteDishIds() async {
    final favoriteDishIds = await _mensaRepository.getFavoriteDishIds() ?? [];
    _favoriteDishIdsNotifier.value = favoriteDishIds;
    _appLogger.logMessage('[MensaUserPreferencesService]: Local favorite dish ids: $favoriteDishIds');

    final unsyncedFavoriteDishIds = await _mensaRepository.getUnsyncedFavoriteDishIds();
    _appLogger.logMessage('[MensaUserPreferencesService]: Unsynced favorite dish ids: $unsyncedFavoriteDishIds');

    for (final unsyncedFavoriteDishId in unsyncedFavoriteDishIds) {
      await _mensaRepository.toggleFavoriteDishId(unsyncedFavoriteDishId);
      await _mensaRepository.removeUnsyncedFavoriteDishId(unsyncedFavoriteDishId);
    }
  }

  Future<void> toggleFavoriteDishId(String dishId) async {
    final favoriteDishIds = List<String>.from(_favoriteDishIdsNotifier.value);

    if (favoriteDishIds.contains(dishId)) {
      favoriteDishIds.remove(dishId);
    } else {
      favoriteDishIds.insert(0, dishId);
    }

    _favoriteDishIdsNotifier.value = favoriteDishIds;
    await _mensaRepository.saveFavoriteDishIds(favoriteDishIds);

    try {
      await _mensaRepository.toggleFavoriteDishId(dishId);
    } catch (e) {
      await _mensaRepository.saveUnsyncedFavoriteDishId(dishId);
    }
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
}
