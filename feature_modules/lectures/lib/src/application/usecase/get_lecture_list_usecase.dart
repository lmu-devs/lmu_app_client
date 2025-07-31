import 'package:flutter/foundation.dart';

import '../../domain/model/lecture.dart';

enum LectureListLoadState { initial, loading, success, error }

class GetLectureListUsecase extends ChangeNotifier {
  GetLectureListUsecase();

  LectureListLoadState _loadState = LectureListLoadState.initial;
  List<Lecture> _lectures = [];
  bool _isFacultyFavorite = false;
  bool _showOnlyFavorites = false;
  String _selectedSemester = 'Winter 24/25';

  // Getters
  LectureListLoadState get loadState => _loadState;
  List<Lecture> get lectures => _lectures;
  bool get isFacultyFavorite => _isFacultyFavorite;
  bool get showOnlyFavorites => _showOnlyFavorites;
  String get selectedSemester => _selectedSemester;
  int get lectureCount => _getFilteredLectures().length;

  // Computed properties
  List<Lecture> get filteredLectures => _getFilteredLectures();
  List<Lecture> get groupedLectures => _getGroupedLectures();

  List<Lecture> _getFilteredLectures() {
    if (!_showOnlyFavorites) return _lectures;
    return _lectures.where((lecture) => lecture.isFavorite).toList();
  }

  List<Lecture> _getGroupedLectures() {
    final filtered = _getFilteredLectures();
    final sorted = List<Lecture>.from(filtered)..sort((a, b) => a.title.compareTo(b.title));
    return sorted;
  }

  // Actions
  void toggleFacultyFavorite() {
    _isFacultyFavorite = !_isFacultyFavorite;
    notifyListeners();
  }

  void toggleFavoritesFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  void setSemester(String semester) {
    _selectedSemester = semester;
    notifyListeners();
  }

  void toggleLectureFavorite(String lectureId) {
    final index = _lectures.indexWhere((lecture) => lecture.id == lectureId);
    if (index != -1) {
      _lectures[index] = _lectures[index].copyWith(isFavorite: !_lectures[index].isFavorite);
      notifyListeners();
    }
  }

  Future<void> load() async {
    if (_loadState == LectureListLoadState.loading) return;

    _loadState = LectureListLoadState.loading;
    notifyListeners();

    try {
      // TODO: Replace with real API call
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
      _lectures = _getMockLectures();
      _loadState = LectureListLoadState.success;
    } catch (e) {
      _loadState = LectureListLoadState.error;
    }

    notifyListeners();
  }

  // Mock data for testing
  List<Lecture> _getMockLectures() {
    return [
      const Lecture(
        id: '1',
        title: 'Credit Risk Modelling',
        tags: ['VL', '6 SWS', 'Master', 'English'],
        isFavorite: false,
      ),
      const Lecture(
        id: '2',
        title: 'Cybersecurity',
        tags: ['VL', '4 SWS', 'Bachelor', 'German'],
        isFavorite: true,
      ),
      const Lecture(
        id: '3',
        title: 'Game Development',
        tags: ['VL', '8 SWS', 'Bachelor', 'English'],
        isFavorite: false,
      ),
    ];
  }
}
