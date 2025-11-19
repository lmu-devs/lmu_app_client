import 'package:core/logging.dart';
import 'package:flutter/foundation.dart';

import '../../domain/exception/courses_generic_exception.dart';
import '../../domain/interface/courses_repository_interface.dart';
import '../../domain/model/course_model.dart';

enum CoursesLoadState { initial, loading, success, error }

class GetCoursesUsecase extends ChangeNotifier {
  GetCoursesUsecase(this._repository);

  final CoursesRepositoryInterface _repository;

  CoursesLoadState _loadState = CoursesLoadState.initial;
  List<CourseModel> _data = [];

  CoursesLoadState get loadState => _loadState;
  List<CourseModel> get data => _data;

  Future<void> load(int facultyId) async {
    if (_loadState == CoursesLoadState.loading || _loadState == CoursesLoadState.success) {
      return;
    }

    _loadState = CoursesLoadState.loading;
    _data = [];
    notifyListeners();

    try {
      final result = await _repository.getCourses(facultyId);
      _loadState = CoursesLoadState.success;
      _data = result;
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
