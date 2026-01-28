import 'package:core/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../domain/exception/courses_generic_exception.dart';
import '../../domain/interface/courses_repository_interface.dart';
import '../../domain/model/course_model.dart';
import 'get_available_semesters_usecase.dart';

enum CoursesLoadState { initial, loading, success, error }

class GetCoursesUsecase extends ChangeNotifier {
  GetCoursesUsecase(this._repository);

  final CoursesRepositoryInterface _repository;

  CoursesLoadState _loadState = CoursesLoadState.initial;
  List<CourseModel> _data = [];

  CoursesLoadState get loadState => _loadState;
  List<CourseModel> get data => _data;
  int? _lastLoadedFacultyId;
  String? _lastLoadedSemesterType;
  int? _lastLoadedYear;

  Future<void> load(int facultyId, [String? semesterType, int? year]) async {
    if (_loadState == CoursesLoadState.loading) {
      return;
    }

    if (_lastLoadedFacultyId == facultyId && _lastLoadedSemesterType == semesterType && _lastLoadedYear == year && _loadState == CoursesLoadState.success) {
      return;
    }

    _lastLoadedFacultyId = facultyId;

    _loadState = CoursesLoadState.loading;
    _data = [];
    notifyListeners();

    try {
      if (semesterType == null || year == null) {
        final semesters = GetIt.I<GetAvailableSemestersUsecase>().data;

        if (semesters == null) {
          throw const CoursesGenericException();
        }

        semesterType = semesters.currentSemester.semesterType;
        year = semesters.currentSemester.year;
      }

      final result = await _repository.getCourses(facultyId, semesterType, year);
      _loadState = CoursesLoadState.success;
      _data = result;
      _lastLoadedSemesterType = semesterType;
      _lastLoadedYear = year;
    } on CoursesGenericException {
      _loadState = CoursesLoadState.error;
      _data = [];
    }

    notifyListeners();

    AppLogger().logMessage(
      "[GetCoursesUsecase]: loaded ${_data.length} courses for faculty $facultyId.",
    );
  }
}
