import 'dart:async';

import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../repository/repository.dart';

class MensaSearchService {
  final _sportsCubit = GetIt.I.get<MensaCubit>();
  final _mensaRepository = GetIt.I.get<MensaRepository>();

  List<String> _recentSearchIds = [];

  List<String> get recentSearchIds => _recentSearchIds;

  List<MensaModel> _mensaModels = [];
  List<MensaModel> _popularMensaModels = [];

  StreamSubscription? _cubitSubscription;

  List<MensaModel> get mensaModels => _mensaModels;
  List<MensaModel> get popularMensaModels => _popularMensaModels;

  void init() {
    _cubitSubscription = _sportsCubit.stream.withInitialValue(_sportsCubit.state).listen((state) {
      if (state is MensaLoadSuccess) {
        _mensaModels = state.mensaModels;
        _mensaRepository.getRecentSearches().then((recentSearch) {
          _recentSearchIds = recentSearch;
        });

        final popularMensa = List.of(_mensaModels);
        popularMensa.sort((a, b) => b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount));
        _popularMensaModels = popularMensa.take(4).toList();
      }
    });
  }

  MensaModel getMensaModel(String id) {
    return _mensaModels.firstWhere((mensaModel) => mensaModel.canteenId == id);
  }

  void dispose() {
    _cubitSubscription?.cancel();
  }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    if (listEquals(_recentSearchIds, recentSearch)) return;
    _recentSearchIds = recentSearch;
    await _mensaRepository.saveRecentSearches(recentSearch);
  }
}
