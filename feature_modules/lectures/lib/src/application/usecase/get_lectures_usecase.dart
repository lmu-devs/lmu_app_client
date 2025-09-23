import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

import '../../domain/exception/lectures_generic_exception.dart';
import '../../domain/interface/lectures_repository_interface.dart';
import '../../domain/model/lecture.dart';
import 'favorite_lectures_usecase.dart';

enum LecturesLoadState { initial, loading, loadingWithCache, success, error }

class GetLecturesUsecase {
  GetLecturesUsecase(this._repository, this._favoritesUsecase);

  final LecturesRepositoryInterface _repository;
  final FavoriteLecturesUsecase _favoritesUsecase;

  LecturesLoadState _loadState = LecturesLoadState.initial;
  List<Lecture> _data = [];
  int? _facultyId;
  int _termId = _defaultTermId;
  int _year = _defaultYear;
  bool _showOnlyFavorites = false;

  // Default values for semester and year
  static const int _defaultTermId = 1;
  static const int _defaultYear = 2025;

  // ValueNotifiers for state management
  final ValueNotifier<LecturesLoadState> loadStateNotifier = ValueNotifier(LecturesLoadState.initial);
  final ValueNotifier<List<Lecture>> dataNotifier = ValueNotifier([]);
  final ValueNotifier<bool> showOnlyFavoritesNotifier = ValueNotifier(false);

  LecturesLoadState get loadState => _loadState;
  List<Lecture> get data => _data;
  bool get showOnlyFavorites => _showOnlyFavorites;

  void setFacultyId(int facultyId, {int termId = _defaultTermId, int year = _defaultYear}) {
    final previousFacultyId = _facultyId;
    _facultyId = facultyId;
    _termId = termId;
    _year = year;

    // If faculty ID changed, reset state and load new data
    if (previousFacultyId != facultyId) {
      _loadState = LecturesLoadState.initial;
      _data = [];
      loadStateNotifier.value = _loadState;
      dataNotifier.value = _data;
      load();
    }
  }

  Future<void> load() async {
    if (_facultyId == null) return;

    if (_loadState == LecturesLoadState.loading || _loadState == LecturesLoadState.loadingWithCache) {
      return;
    }

    // Try to load from cache first
    try {
      final cachedLectures = await _repository.getCachedLecturesByFaculty(_facultyId!, termId: _termId, year: _year);
      if (cachedLectures.isNotEmpty) {
        _loadState = LecturesLoadState.loadingWithCache;
        _data = cachedLectures;
        loadStateNotifier.value = _loadState;
        dataNotifier.value = _data;

        // Load fresh data in background without blocking UI
        _loadFreshDataInBackground();
        return;
      } else {
        _loadState = LecturesLoadState.loading;
        _data = [];
        loadStateNotifier.value = _loadState;
        dataNotifier.value = _data;
      }
    } catch (e) {
      _loadState = LecturesLoadState.loading;
      _data = [];
      loadStateNotifier.value = _loadState;
      dataNotifier.value = _data;
    }

    // Load from API
    await _loadFromApi();
  }

  Future<void> _loadFreshDataInBackground() async {
    try {
      final currentFacultyId = _facultyId;
      final freshLectures = await _repository.getLecturesByFaculty(currentFacultyId!, termId: _termId, year: _year);

      // Only update if we still have the same faculty ID (user hasn't navigated away)
      if (_facultyId == currentFacultyId) {
        _data = freshLectures;
        _loadState = LecturesLoadState.success;
        loadStateNotifier.value = _loadState;
        dataNotifier.value = _data;
      }
    } catch (e) {
      // Keep showing cached data, don't change state
    }
  }

  Future<void> _loadFromApi() async {
    try {
      _data = await _repository.getLecturesByFaculty(_facultyId!, termId: _termId, year: _year);
      _loadState = LecturesLoadState.success;
    } on LecturesGenericException {
      // If API fails and we have no cached data, show error
      if (_data.isEmpty) {
        _loadState = LecturesLoadState.error;
        // TODO: Add proper error logging with context
      } else {
        // Keep cached data and show success state
        _loadState = LecturesLoadState.success;
        // TODO: Log that we're showing cached data due to API error
      }
    } catch (e) {
      // Handle unexpected errors
      if (_data.isEmpty) {
        _loadState = LecturesLoadState.error;
        // TODO: Add proper error logging
      } else {
        _loadState = LecturesLoadState.success;
        // TODO: Log that we're showing cached data due to unexpected error
      }
    }

    loadStateNotifier.value = _loadState;
    dataNotifier.value = _data;
  }

  List<Lecture> get filteredLectures {
    if (_showOnlyFavorites) {
      return favoriteLectures;
    }
    return _data;
  }

  List<Lecture> get favoriteLectures {
    return _data.where((lecture) => _favoritesUsecase.isFavorite(lecture.id)).toList();
  }

  void toggleFavoritesFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    showOnlyFavoritesNotifier.value = _showOnlyFavorites;
  }

  Future<void> reload() async {
    _loadState = LecturesLoadState.initial;
    _data = [];
    loadStateNotifier.value = _loadState;
    dataNotifier.value = _data;
    await load();
  }

  // Preload data for all faculties in background
  static Future<void> preloadAllFaculties() async {
    final repository = GetIt.I.get<LecturesRepositoryInterface>();
    final faculties = GetIt.I.get<FacultiesApi>().allFaculties;

    // Preload first few faculties in parallel
    final futures = faculties.take(_preloadFacultyCount).map((faculty) async {
      try {
        await repository.getLecturesByFaculty(faculty.id);
      } catch (e) {
        // TODO: Handle preload errors gracefully
      }
    });

    await Future.wait(futures);
  }

  // Configuration constants
  static const int _preloadFacultyCount = 5;

  void dispose() {
    loadStateNotifier.dispose();
    dataNotifier.dispose();
    showOnlyFavoritesNotifier.dispose();
  }
}
