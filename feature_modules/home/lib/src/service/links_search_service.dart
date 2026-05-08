import 'dart:async';

import 'package:core/utils.dart';
import 'package:get_it/get_it.dart';
import '../bloc/links/links.dart';
import '../repository/api/api.dart';
import '../repository/repository.dart';

class LinksSearchService {
  final _linksCubit = GetIt.I.get<LinksCubit>();
  final _homeRepository = GetIt.I.get<HomeRepository>();

  List<LinkModel> _recentSearches = [];

  List<LinkModel> get recentSearches => _recentSearches;

  List<LinkModel> _links = [];

  StreamSubscription? _cubitSubscription;

  List<LinkModel> get links => _links;

  void _updateRecentSearch(List<String> recentSearch) {
    _recentSearches = _links.where((link) => recentSearch.contains(link.id)).toList()
      ..sort((a, b) => recentSearch.indexOf(a.id).compareTo(recentSearch.indexOf(b.id)));
  }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    if (_recentSearches.map((link) => link.id).toList() == recentSearch) return;
    _updateRecentSearch(recentSearch);
    await _homeRepository.saveRecentLinkSearches(recentSearch);
  }

  void init() {
    _cubitSubscription = _linksCubit.stream.withInitialValue(_linksCubit.state).listen((state) {
      if (state is LinksLoadSuccess) {
        _links = state.links;
        _homeRepository.getRecentLinkSearches().then((recentSearch) {
          _updateRecentSearch(recentSearch);
        });
      }
    });
  }

  void dispose() {
    _cubitSubscription?.cancel();
  }
}
