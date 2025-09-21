import 'package:flutter/foundation.dart';

import '../../domain/exception/lectures_generic_exception.dart';
import '../../domain/interface/lectures_repository_interface.dart';
import '../../domain/model/lecture.dart';
import 'favorite_lectures_usecase.dart';

enum LecturesLoadState { initial, loading, loadingWithCache, success, error }

class GetLecturesUsecase extends ChangeNotifier {
  GetLecturesUsecase(this._repository, this._favoritesUsecase);

  final LecturesRepositoryInterface _repository;
  final FavoriteLecturesUsecase _favoritesUsecase;

  LecturesLoadState _loadState = LecturesLoadState.initial;
  List<Lecture> _data = [];
  int? _facultyId;
  int _termId = 1;
  int _year = 2025;
  bool _showOnlyFavorites = false;

  LecturesLoadState get loadState => _loadState;
  List<Lecture> get data => _data;
  bool get showOnlyFavorites => _showOnlyFavorites;

      void setFacultyId(int facultyId, {int termId = 1, int year = 2025}) {
        final previousFacultyId = _facultyId;
        _facultyId = facultyId;
        _termId = termId;
        _year = year;
        
        print('🔄 setFacultyId: $previousFacultyId -> $facultyId');
        
        // If faculty ID changed, reset state and load new data
        if (previousFacultyId != facultyId) {
          print('🔄 Faculty ID changed, resetting state and loading new data');
          _loadState = LecturesLoadState.initial;
          _data = [];
          notifyListeners();
          load();
        }
      }

      Future<void> load() async {
        if (_facultyId == null) return;
        
        print('📚 GetLecturesUsecase.load() called for facultyId: $_facultyId, current state: $_loadState');
        
        if (_loadState == LecturesLoadState.loading ||
            _loadState == LecturesLoadState.loadingWithCache) {
          print('⏸️ Load already in progress, skipping');
          return;
        }

    // Try to load from cache first
    try {
      final cachedLectures = await _repository.getCachedLecturesByFaculty(_facultyId!, termId: _termId, year: _year);
      if (cachedLectures.isNotEmpty) {
        _loadState = LecturesLoadState.loadingWithCache;
        _data = cachedLectures;
        notifyListeners();
      } else {
        _loadState = LecturesLoadState.loading;
        _data = [];
        notifyListeners();
      }
    } catch (e) {
      _loadState = LecturesLoadState.loading;
      _data = [];
      notifyListeners();
    }

    try {
      _data = await _repository.getLecturesByFaculty(_facultyId!, termId: _termId, year: _year);
      _loadState = LecturesLoadState.success;
    } on LecturesGenericException {
      // If API fails and we have no cached data, show error
      if (_data.isEmpty) {
        _loadState = LecturesLoadState.error;
      } else {
        // Keep cached data and show success state
        _loadState = LecturesLoadState.success;
      }
    }

    notifyListeners();
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

  List<Lecture> get nonFavoriteLectures {
    return _data.where((lecture) => !_favoritesUsecase.isFavorite(lecture.id)).toList();
  }

  void toggleFavoritesFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  Future<void> reload() async {
    print('🔄 Reloading lectures for faculty $_facultyId');
    _loadState = LecturesLoadState.initial;
    _data = [];
    notifyListeners();
    await load();
  }
}
