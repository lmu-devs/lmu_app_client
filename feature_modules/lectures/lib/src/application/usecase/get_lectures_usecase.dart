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

  LecturesLoadState get loadState => _loadState;
  List<Lecture> get data => _data;
  int? get facultyId => _facultyId;
  bool get showOnlyFavorites => _showOnlyFavorites;

  // Filtered data based on current state
  List<Lecture> get filteredLectures {
    if (_data.isEmpty) return [];

    var filtered = _data;

    // Filter by faculty if specified
    if (_facultyId != null) {
      filtered = filtered.where((lecture) => lecture.facultyId == _facultyId).toList();
    }

    return filtered;
  }

  List<Lecture> get favoriteLectures {
    return filteredLectures.where((lecture) => _favoritesUsecase.isFavorite(lecture.id)).toList();
  }

  List<Lecture> get nonFavoriteLectures {
    return filteredLectures.where((lecture) => !_favoritesUsecase.isFavorite(lecture.id)).toList();
  }

  int get lectureCount => filteredLectures.length;

  void setFacultyId(int facultyId) {
    _facultyId = facultyId;
    notifyListeners();
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
    if (_loadState == LecturesLoadState.loading || _loadState == LecturesLoadState.success) {
      return;
    }

    _loadState = LecturesLoadState.loading;
    _data = [];
    notifyListeners();

    try {
      final result = await _repository.getLectures();
      _loadState = LecturesLoadState.success;
      _data = result;
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
