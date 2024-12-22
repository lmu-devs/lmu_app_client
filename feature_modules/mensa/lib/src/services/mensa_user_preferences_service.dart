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
      getSortOption(),
      initFavoriteMensaIds(),
      getFavoriteDishIds(),
      getSelectedPriceCategory(),
    ]);
  }

  SortOption _initialSortOption = SortOption.alphabetically;
  SortOption get initialSortOption => _initialSortOption;

  PriceCategory _initialPriceCategory = PriceCategory.students;
  PriceCategory get initialPriceCategory => _initialPriceCategory;

  final _favoriteMensaIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteMensaIdsNotifier => _favoriteMensaIdsNotifier;

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
}
