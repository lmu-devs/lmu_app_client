import 'dart:async';

import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../repository/repository.dart';

class LibrariesSearchService {
  final _librariesCubit = GetIt.I.get<LibrariesCubit>();
  final _librariesRepository = GetIt.I.get<LibrariesRepository>();

  List<String> _recentSearchIds = [];

  List<String> get recentSearchIds => _recentSearchIds;

  List<LibraryModel> _libraries = [];
  List<LibraryModel> _popularLibraries = [];

  StreamSubscription? _cubitSubscription;

  List<LibraryModel> get libraries => _libraries;

  List<LibraryModel> get popularLibraries => _popularLibraries;

  void init() {
    _cubitSubscription = _librariesCubit.stream.withInitialValue(_librariesCubit.state).listen((state) {
      if (state is LibrariesLoadSuccess) {
        _libraries = state.libraries;
        _librariesRepository.getRecentSearches().then((recentSearch) {
          _recentSearchIds = recentSearch;
        });

        final popularLibrary = List.of(_libraries);
        popularLibrary.sort((a, b) => b.rating.likeCount.compareTo(a.rating.likeCount));
        _popularLibraries = popularLibrary.take(4).toList();
      }
    });
  }

  LibraryModel getLibrary(String id) {
    return _libraries.firstWhere((library) => library.id == id);
  }

  void dispose() {
    _cubitSubscription?.cancel();
  }

  Future<void> updateRecentSearch(List<String> recentSearch) async {
    if (listEquals(_recentSearchIds, recentSearch)) return;
    _recentSearchIds = recentSearch;
    await _librariesRepository.saveRecentSearches(recentSearch);
  }
}
