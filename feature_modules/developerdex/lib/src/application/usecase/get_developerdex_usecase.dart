import 'package:flutter/foundation.dart';

import '../../domain/interface/developerdex_repository_interface.dart';
import '../../domain/model/semester_course.dart';

class GetDeveloperdexUsecase extends ChangeNotifier {
  GetDeveloperdexUsecase(this._repository);

  final DeveloperdexRepositoryInterface _repository;

  List<SemesterCourse> _semesterCourses = [];
  List<String> _seenEntries = [];

  List<SemesterCourse> get semesterCourses => _semesterCourses;
  List<String> get seenEntries => _seenEntries;

  bool caughtDeveloper(String id) {
    final isNew = !_seenEntries.contains(id);

    if (!isNew) return false;
    _seenEntries.add(id);
    _repository.saveSeenDeleoperdexIds(_seenEntries);
    notifyListeners();
    return true;
  }

  void initDevelopers() async {
    _semesterCourses = _repository.getSemesterCourses();
    _seenEntries = await _repository.getSeenEntries();

    notifyListeners();
  }
}
