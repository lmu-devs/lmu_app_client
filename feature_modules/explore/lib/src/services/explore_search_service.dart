import 'package:get_it/get_it.dart';

import '../repository/explore_repository.dart';

class ExploreSearchService {
  final _repository = GetIt.I.get<ExploreRepository>();

  List<String> _recentSearches = [];

  List<String> get recentSearches => _recentSearches;

  Future<void> init() async {
    _recentSearches = await _repository.getRecentSearches();
  }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    _recentSearches = recentSearch;
    await _repository.saveRecentSearches(recentSearch);
  }
}
