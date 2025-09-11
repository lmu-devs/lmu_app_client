import 'package:flutter/foundation.dart';

import '../../domain/exception/lectures_generic_exception.dart';
import '../../domain/interface/lectures_repository_interface.dart';
import '../../domain/model/lecture.dart';
import 'favorite_lectures_usecase.dart';

enum LecturesLoadState { initial, loading, success, error }

class GetLecturesUsecase extends ChangeNotifier {
  GetLecturesUsecase(this._repository, this._favoritesUsecase) {
    _favoritesUsecase.addListener(_onFavoritesChanged);
  }

  final LecturesRepositoryInterface _repository;
  final FavoriteLecturesUsecase _favoritesUsecase;

  LecturesLoadState _loadState = LecturesLoadState.initial;
  List<Lecture> _data = [];
  int? _facultyId;
  bool _showOnlyFavorites = false;
  bool _isInitialized = false;

  LecturesLoadState get loadState => _loadState;
  List<Lecture> get data => _data;
  int? get facultyId => _facultyId;
  bool get showOnlyFavorites => _showOnlyFavorites;

  // Optimized single-pass filtering with memoization
  List<Lecture>? _cachedFilteredLectures;
  int? _lastFacultyId;
  
  List<Lecture> get filteredLectures {
    // Return cached result if faculty hasn't changed
    if (_lastFacultyId == _facultyId && _cachedFilteredLectures != null) {
      return _cachedFilteredLectures!;
    }

    // Recalculate and cache
    if (_data.isEmpty) {
      _cachedFilteredLectures = _data;
    } else if (_facultyId != null) {
      _cachedFilteredLectures = _data.where((lecture) => lecture.facultyId == _facultyId).toList();
    } else {
      _cachedFilteredLectures = _data;
    }
    
    _lastFacultyId = _facultyId;
    return _cachedFilteredLectures!;
  }

  List<Lecture> get favoriteLectures {
    return filteredLectures.where((lecture) => _favoritesUsecase.isFavorite(lecture.id)).toList();
  }

  List<Lecture> get nonFavoriteLectures {
    return filteredLectures.where((lecture) => !_favoritesUsecase.isFavorite(lecture.id)).toList();
  }

  int get lectureCount => filteredLectures.length;

  void setFacultyId(int facultyId) {
    if (_facultyId != facultyId) {
      _facultyId = facultyId;
      // Clear cache to force recalculation
      _cachedFilteredLectures = null;
      _lastFacultyId = null;
      notifyListeners();
    }
  }

  void toggleFavoritesFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  void setShowOnlyFavorites(bool showOnly) {
    _showOnlyFavorites = showOnly;
    notifyListeners();
  }

  void _onFavoritesChanged() {
    notifyListeners();
  }

  Future<void> load() async {
    // Prevent concurrent loading
    if (_loadState == LecturesLoadState.loading) {
      return;
    }

    // Try cache-first loading
    if (!_isInitialized) {
      await _loadFromCache();
    }

    // If no cache or cache failed, load fresh data
    if (_data.isEmpty) {
      await _loadFreshData();
    }
  }

  Future<void> _loadFromCache() async {
    try {
      final cachedData = await _repository.getCachedLectures();
      if (cachedData != null && cachedData.isNotEmpty) {
        _data = cachedData;
        _loadState = LecturesLoadState.success;
        _isInitialized = true;
        notifyListeners();
      }
    } catch (e) {
      // Cache failed, will load fresh data
    }
  }

  Future<void> _loadFreshData() async {
    _loadState = LecturesLoadState.loading;
    notifyListeners();

    try {
      final result = await _repository.getLectures();
      _loadState = LecturesLoadState.success;
      _data = result;
      _isInitialized = true;
    } on LecturesGenericException {
      _loadState = LecturesLoadState.error;
      _data = [];
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _favoritesUsecase.removeListener(_onFavoritesChanged);
    super.dispose();
  }
}
