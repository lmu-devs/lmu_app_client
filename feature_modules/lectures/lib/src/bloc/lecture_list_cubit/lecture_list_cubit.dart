import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/interface/lectures_repository_interface.dart';
import '../../domain/model/lecture.dart';
import 'lecture_list_state.dart';

class LectureListCubit extends Cubit<LectureListState> {
  LectureListCubit({required this.facultyId}) : super(LectureListInitial());

  final String facultyId;
  final _repository = GetIt.I.get<LecturesRepositoryInterface>();

  List<Lecture> _lectures = [];
  bool _isFacultyFavorite = false;
  bool _showOnlyFavorites = false;
  String _selectedSemester = 'Winter 24/25';

  List<Lecture> get lectures => _lectures;
  bool get isFacultyFavorite => _isFacultyFavorite;
  bool get showOnlyFavorites => _showOnlyFavorites;
  String get selectedSemester => _selectedSemester;
  int get lectureCount => _getFilteredLectures().length;

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

  void toggleFacultyFavorite() {
    _isFacultyFavorite = !_isFacultyFavorite;
    _emitCurrentState();
  }

  void toggleFavoritesFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    _emitCurrentState();
  }

  void setSemester(String semester) {
    _selectedSemester = semester;
    _emitCurrentState();
  }

  void toggleLectureFavorite(String lectureId) {
    final index = _lectures.indexWhere((lecture) => lecture.id == lectureId);
    if (index != -1) {
      _lectures[index] = _lectures[index].copyWith(isFavorite: !_lectures[index].isFavorite);
      _emitCurrentState();
    }
  }

  Future<void> loadLectures() async {
    if (kDebugMode) {
      debugPrint('LectureListCubit.loadLectures: Loading lectures for facultyId = "$facultyId"');
    }
    final cachedLectures = await _repository.getCachedLectures();
    if (cachedLectures != null) {
      emit(LectureListLoadInProgress(lectures: _getMockLectures()));
    } else {
      emit(LectureListLoadInProgress());
    }

    try {
      // TODO: Replace with real API call using facultyId
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
      _lectures = _getMockLectures();
      emit(LectureListLoadSuccess(
        lectures: _lectures,
        isFacultyFavorite: _isFacultyFavorite,
        showOnlyFavorites: _showOnlyFavorites,
        selectedSemester: _selectedSemester,
      ));
    } catch (e) {
      if (cachedLectures != null) {
        emit(LectureListLoadSuccess(
          lectures: _lectures,
          isFacultyFavorite: _isFacultyFavorite,
          showOnlyFavorites: _showOnlyFavorites,
          selectedSemester: _selectedSemester,
        ));
      } else {
        emit(const LectureListLoadFailure(loadState: LoadState.genericError));
      }
    }
  }

  void _emitCurrentState() {
    if (state is LectureListLoadSuccess) {
      emit(LectureListLoadSuccess(
        lectures: _lectures,
        isFacultyFavorite: _isFacultyFavorite,
        showOnlyFavorites: _showOnlyFavorites,
        selectedSemester: _selectedSemester,
      ));
    }
  }

  // Mock data for testing - TODO: Remove when real API is implemented
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
