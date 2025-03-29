import 'dart:async';

import 'package:core/utils.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../repository/repository.dart';

class MensaSearchService {
  final _sportsCubit = GetIt.I.get<MensaCubit>();
  final _mensaRepository = GetIt.I.get<MensaRepository>();

  List<MensaModel> _recentSearches = [];

  List<MensaModel> get recentSearches => _recentSearches;

  List<MensaModel> _mensaModels = [];
  List<MensaModel> _popularMensaModels = [];

  StreamSubscription? _cubitSubscription;

  List<MensaModel> get mensaModels => _mensaModels;
  List<MensaModel> get popularMensaModels => _popularMensaModels;

  void _updateRecentSearch(List<String> recentSearch) {
    _recentSearches = _mensaModels.where((mensaModel) => recentSearch.contains(mensaModel.canteenId)).toSet().toList()
      ..sort((a, b) => recentSearch.indexOf(a.name).compareTo(recentSearch.indexOf(b.name)));
  }

  void init() {
    _cubitSubscription = _sportsCubit.stream.withInitialValue(_sportsCubit.state).listen((state) {
      if (state is MensaLoadSuccess) {
        _mensaModels = state.mensaModels;
        _mensaRepository.getRecentSearches().then((recentSearch) {
          _updateRecentSearch(recentSearch);
        });

        final popularMensa = List.of(_mensaModels);
        popularMensa.sort((a, b) => b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount));
        _popularMensaModels = popularMensa.take(3).toList();
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
    if (_recentSearches.map((search) => search.canteenId).toList() == recentSearch) return;
    _updateRecentSearch(recentSearch);
    await _mensaRepository.saveRecentSearches(recentSearch);
  }
}
