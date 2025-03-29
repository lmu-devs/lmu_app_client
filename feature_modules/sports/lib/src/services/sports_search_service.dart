import 'dart:async';
import 'dart:math';

import 'package:core/utils.dart';
import 'package:get_it/get_it.dart';

import '../cubit/sports_cubit/cubit.dart';
import '../repository/repository.dart';

class SportsSearchService {
  final _sportsCubit = GetIt.I.get<SportsCubit>();
  final _sportsRepository = GetIt.I.get<SportsRepository>();

  List<SportsType> _recentSearches = [];

  List<SportsType> get recentSearches => _recentSearches;

  List<SportsType> _sportsTypes = [];
  List<SportsType> _sportsRecommendations = [];

  StreamSubscription? _cubitSubscription;

  List<SportsType> get sportsTypes => _sportsTypes;

  List<SportsType> get sportsRecommendations => _sportsRecommendations;

  void _updateRecentSearch(List<String> recentSearch) {
    _recentSearches = _sportsTypes.where((sportType) => recentSearch.contains(sportType.title)).toList()
      ..sort((a, b) => recentSearch.indexOf(a.title).compareTo(recentSearch.indexOf(b.title)));
  }

  void init() {
    _cubitSubscription = _sportsCubit.stream.withInitialValue(_sportsCubit.state).listen((state) {
      if (state is SportsLoadSuccess) {
        _sportsTypes = state.sports.sportTypes;
        _sportsRepository.getRecentSearches().then((recentSearch) {
          _updateRecentSearch(recentSearch);
        });
        final random = Random();
        final sportsRecommendations = List.of(_sportsTypes);
        sportsRecommendations.shuffle(random);
        _sportsRecommendations = sportsRecommendations.take(4).toList();
      }
    });
  }

  SportsType getSportType(String title) {
    return _sportsTypes.firstWhere((sportType) => sportType.title == title);
  }

  void dispose() {
    _cubitSubscription?.cancel();
  }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    if (_recentSearches.map((building) => building.title).toList() == recentSearch) return;
    _updateRecentSearch(recentSearch);
    await _sportsRepository.saveRecentSearches(recentSearch);
  }
}
