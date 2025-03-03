import 'package:core/logging.dart';
import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../extensions/sort_option_sort_extension.dart';
import '../repository/api/models/mensa/mensa_model.dart';
import '../repository/api/models/user_preferences/sort_option.dart';
import '../repository/mensa_repository.dart';

class MensaUserPreferencesService {
  MensaUserPreferencesService() {
    _init();
  }

  ValueNotifier<bool> get isOpenNowFilterNotifier => _isOpenNowFilterNotifier;
  ValueNotifier<SortOption> get sortOptionNotifier => _sortOptionNotifier;
  ValueNotifier<List<MensaModel>> get sortedMensaModelsNotifier => _sortedMensaModelsNotifier;
  ValueNotifier<List<String>> get favoriteMensaIdsNotifier => _favoriteMensaIdsNotifier;
  ValueNotifier<List<String>> get favoriteDishIdsNotifier => _favoriteDishIdsNotifier;

  final _mensaRepository = GetIt.I.get<MensaRepository>();
  final _appLogger = AppLogger();
  final _isOpenNowFilterNotifier = ValueNotifier<bool>(false);
  final _sortOptionNotifier = ValueNotifier<SortOption>(SortOption.rating);
  final _sortedMensaModelsNotifier = ValueNotifier<List<MensaModel>>([]);
  final _favoriteMensaIdsNotifier = ValueNotifier<List<String>>([]);
  final _favoriteDishIdsNotifier = ValueNotifier<List<String>>([]);

  void dispose() {
    _isOpenNowFilterNotifier.dispose();
    _sortOptionNotifier.dispose();
    _sortedMensaModelsNotifier.dispose();
    _favoriteMensaIdsNotifier.dispose();
    _favoriteDishIdsNotifier.dispose();
  }

  Future _init() {
    return Future.wait([
      _initFavoriteMensaIds(),
      _initFavoriteDishIds(),
      _initSortOption(),
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

  // Mensa Favorites

  Future<void> _initFavoriteMensaIds() async {
    final favoriteMensaIds = await _mensaRepository.getFavoriteMensaIds() ?? [];
    _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    _appLogger.logMessage('[MensaUserPreferencesService]: Local favorite mensa ids: $favoriteMensaIds');

    final mensaCubit = GetIt.I<MensaCubit>();
    final mensaCubitState = mensaCubit.state;
    mensaCubit.stream.withInitialValue(mensaCubitState).listen((state) async {
      if (state is MensaLoadSuccess) {
        sortMensaModels(state.mensaModels);
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

  Future<void> toggleFavoriteMensaId(String mensaId, {int? insertIndex}) async {
    final favoriteMensaIds = List<String>.from(_favoriteMensaIdsNotifier.value);

    if (favoriteMensaIds.contains(mensaId)) {
      favoriteMensaIds.remove(mensaId);
    } else {
      favoriteMensaIds.insert(insertIndex ?? favoriteMensaIds.length, mensaId);
    }

    _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    await _mensaRepository.saveFavoriteMensaIds(favoriteMensaIds);
    await _mensaRepository.toggleFavoriteMensaId(mensaId);
  }

  // Dish Favorites

  Future<void> _initFavoriteDishIds() async {
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

  // Mensa Sorting and Filtering

  void sortMensaModels(List<MensaModel> mensaModels) {
    final sortedMensaModels = _sortOptionNotifier.value.sort(mensaModels);
    _sortedMensaModelsNotifier.value = sortedMensaModels;
  }

  Future<void> _initSortOption() async {
    final loadedSortOption = await _mensaRepository.getSortOption();

    if (loadedSortOption != null) {
      _sortOptionNotifier.value = loadedSortOption;
    }
  }

  Future<void> updateSortOption(SortOption sortOption) async {
    await _mensaRepository.setSortOption(sortOption);
  }
}
