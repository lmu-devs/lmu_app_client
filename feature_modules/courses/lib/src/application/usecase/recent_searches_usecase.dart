import 'package:flutter/foundation.dart';
import '../../domain/model/course_model.dart';
import '../../infrastructure/secondary/data/storage/courses_recent_searches_storage.dart';
import 'get_courses_usecase.dart';


class RecentSearchesUsecase extends ChangeNotifier {
  RecentSearchesUsecase(this._storage, this._getCoursesUsecase) {
    _load();
  }

  final CoursesRecentSearchesStorage _storage;
  final GetCoursesUsecase _getCoursesUsecase;
  final List<int> _recentSearchIds = [];
  final ValueNotifier<List<CourseModel>> recentSearchesNotifier = ValueNotifier<List<CourseModel>>([]);

  List<CourseModel> get recentSearches {
    final allCourses = _getCoursesUsecase.data;
    return _recentSearchIds
        .map((id) => allCourses.where((course) => course.publishId == id).firstOrNull)
        .whereType<CourseModel>()
        .toList();
  }

  Future<void> addRecentSearch(CourseModel course) async {
    _updateRecentSearchIds(course.publishId);
    await _storage.saveRecentSearches(_recentSearchIds.map((e) => e.toString()).toList());
    _updateRecentSearchesNotifier();
    notifyListeners();
  }

  Future<void> clearRecentSearches() async {
    _recentSearchIds.clear();
    await _storage.clearRecentSearches();
    recentSearchesNotifier.value = [];
    notifyListeners();
  }

  Future<void> _load() async {
    _recentSearchIds.clear();
    final stringIds = await _storage.getRecentSearches();
    _recentSearchIds.addAll(stringIds.map((s) => int.tryParse(s)).whereType<int>());
    _updateRecentSearchesNotifier();
    notifyListeners();
  }

  void _updateRecentSearchIds(int id) {
    _recentSearchIds.remove(id);
    _recentSearchIds.insert(0, id);

    if (_recentSearchIds.length > 10) {
      _recentSearchIds.removeRange(10, _recentSearchIds.length);
    }
  }

  void _updateRecentSearchesNotifier() {
    recentSearchesNotifier.value = recentSearches;
  }
}
