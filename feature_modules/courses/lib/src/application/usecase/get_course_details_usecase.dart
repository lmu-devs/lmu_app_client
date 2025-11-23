import 'package:core/logging.dart';
import 'package:flutter/foundation.dart';

import '../../domain/exception/courses_generic_exception.dart';
import '../../domain/interface/courses_repository_interface.dart';
import '../../domain/model/course_details_model.dart';
import '../../domain/model/course_model.dart';

enum CourseDetailsLoadState { initial, loading, success, error }

class GetCourseDetailsUsecase extends ChangeNotifier {
  GetCourseDetailsUsecase(this._repository);

  final CoursesRepositoryInterface _repository;

  CourseDetailsLoadState _loadState = CourseDetailsLoadState.initial;
  CourseDetailsModel? _data;

  CourseDetailsLoadState get loadState => _loadState;
  CourseDetailsModel? get data => _data;
  int? _lastLoadedCourseId;

  Future<void> load(int courseId) async {
    if (_loadState == CourseDetailsLoadState.loading) {
      return;
    }

    if (_lastLoadedCourseId == courseId && _loadState == CourseDetailsLoadState.success) {
      return;
    }

    _lastLoadedCourseId = courseId;

    _loadState = CourseDetailsLoadState.loading;
    _data = null;
    notifyListeners();

    try {
      final result = await _repository.getCourseDetails(courseId);
      _loadState = CourseDetailsLoadState.success;
      _data = result;
    } on CoursesGenericException {
      _loadState = CourseDetailsLoadState.error;
      _data = null;
    } catch (e) {
      _loadState = CourseDetailsLoadState.error;
      _data = null;
    }

    notifyListeners();

    if (_loadState == CourseDetailsLoadState.success) {
      AppLogger().logMessage(
        "[GetCourseDetailsUsecase]: loaded details for course $courseId.",
      );
    }
  }
}
