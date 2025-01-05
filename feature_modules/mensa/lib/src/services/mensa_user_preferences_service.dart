import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../repository/api/models/menu/price_category.dart';
import '../repository/api/models/user_preferences/user_preferences.dart';
import '../repository/mensa_repository.dart';

class MensaUserPreferencesService {
  MensaUserPreferencesService();

  final _mensaRepository = GetIt.I.get<MensaRepository>();

  Future init() {
    return Future.wait([
      initFavoriteMensaIds(),
      initFavoriteDishIds(),
      getSortOption(),
      getSelectedPriceCategory(),
    ]);
  }

  Future reset() {
    return Future.wait([
      _mensaRepository.deleteAllLocalData(),
      updateSortOption(SortOption.alphabetically),
      updatePriceCategory(PriceCategory.students),
      Future.value(_favoriteMensaIdsNotifier.value = []),
      Future.value(_favoriteDishIdsNotifier.value = []),
    ]);
  }

  SortOption _initialSortOption = SortOption.alphabetically;
  SortOption get initialSortOption => _initialSortOption;

  PriceCategory _initialPriceCategory = PriceCategory.students;
  PriceCategory get initialPriceCategory => _initialPriceCategory;

  final _favoriteMensaIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteMensaIdsNotifier => _favoriteMensaIdsNotifier;

  final _favoriteDishIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteDishIdsNotifier => _favoriteDishIdsNotifier;

  Future<void> initFavoriteMensaIds() async {
    final favoriteMensaIds = await _mensaRepository.getFavoriteMensaIds() ?? [];
    _favoriteMensaIdsNotifier.value = favoriteMensaIds;

    final mensaCubit = GetIt.I<MensaCubit>();
    final mensaCubitState = mensaCubit.state;
    mensaCubit.stream.withInitialValue(mensaCubitState).listen((state) async {
      if (state is MensaLoadSuccess) {
        final retrievedFavoriteMensaIds =
            state.mensaModels.where((mensa) => mensa.ratingModel.isLiked).map((mensa) => mensa.canteenId).toList();
        print("retrievedFavoriteMensaIds: $retrievedFavoriteMensaIds");

        final unsyncedFavoriteMensaIds =
            favoriteMensaIds.where((id) => !retrievedFavoriteMensaIds.contains(id)).toList();
        print("unsyncedFavoriteMensaIds: $unsyncedFavoriteMensaIds");

        final unsyncedUnfavoriteMensaIds =
            retrievedFavoriteMensaIds.where((id) => !favoriteMensaIds.contains(id)).toList();
        print("unsyncedUnfavoriteMensaIds: $unsyncedUnfavoriteMensaIds");

        final missingSyncMensaIds = unsyncedFavoriteMensaIds + unsyncedUnfavoriteMensaIds;
        for (final missingSyncMensaId in missingSyncMensaIds) {
          await toggleFavoriteMensaId(missingSyncMensaId);
        }
      }
    });
  }

  Future<void> toggleFavoriteMensaId(String mensaId) async {
    final favoriteMensaIds = List<String>.from(_favoriteMensaIdsNotifier.value);

    if (favoriteMensaIds.contains(mensaId)) {
      favoriteMensaIds.remove(mensaId);
    } else {
      favoriteMensaIds.insert(0, mensaId);
    }

    _favoriteMensaIdsNotifier.value = favoriteMensaIds;
    await _mensaRepository.saveFavoriteMensaIds(favoriteMensaIds);

    try {
      await _mensaRepository.toggleFavoriteMensaId(mensaId);
    } catch (e) {
      print('Failed to sync toggled favorite mensa $mensaId: $e');
    }
  }

  Future<void> initFavoriteDishIds() async {
    final favoriteDishIds = await _mensaRepository.getFavoriteDishIds() ?? [];
    _favoriteDishIdsNotifier.value = favoriteDishIds;

    final unsyncedFavoriteDishIds = await _mensaRepository.getUnsyncedFavoriteDishIds();
    print("unsyncedFavoriteDishIds: $unsyncedFavoriteDishIds");

    for (final unsyncedFavoriteDishId in unsyncedFavoriteDishIds) {
      try {
        await _mensaRepository.toggleFavoriteDishId(unsyncedFavoriteDishId);
        await _mensaRepository.removeUnsyncedFavoriteDishId(unsyncedFavoriteDishId);
      } catch (e) {
        print('Failed to sync unsynced favorite dish $unsyncedFavoriteDishId: $e');
      }
    }
  }

  Future<void> toggleFavoriteDishId(String dishId) async {
    final favoriteDishIds = List<String>.from(_favoriteDishIdsNotifier.value);

    final isLiked = favoriteDishIds.contains(dishId);

    if (isLiked) {
      favoriteDishIds.remove(dishId);
    } else {
      favoriteDishIds.insert(0, dishId);
    }

    _favoriteDishIdsNotifier.value = favoriteDishIds;
    await _mensaRepository.saveFavoriteDishIds(favoriteDishIds);

    try {
      await _mensaRepository.toggleFavoriteDishId(dishId);
    } catch (e) {
      print('Failed to sync toggled favorite dish $dishId: $e');

      await _mensaRepository.saveUnsyncedFavoriteDishId(dishId, !isLiked);
    }
  }

  Future<void> getSelectedPriceCategory() async {
    final selectedPriceCategory = await _mensaRepository.getPriceCategory();

    if (selectedPriceCategory != null) {
      _initialPriceCategory = selectedPriceCategory;
    }
  }

  Future<void> updatePriceCategory(PriceCategory priceCategory) async {
    _initialPriceCategory = priceCategory;
    await _mensaRepository.setPriceCategory(priceCategory);
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
