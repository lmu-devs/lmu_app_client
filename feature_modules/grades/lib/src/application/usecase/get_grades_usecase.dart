import 'package:flutter/foundation.dart';

import '../../domain/exception/grades_generic_exception.dart';
import '../../domain/interface/grades_repository_interface.dart';
import '../../domain/model/grade.dart';

enum GradesLoadState { initial, loading, loadingWithCache, success, error }

class GetGradesUsecase extends ChangeNotifier {
  GetGradesUsecase(this._repository);

  final GradesRepositoryInterface _repository;

  GradesLoadState _loadState = GradesLoadState.initial;
  List<Grade> _data = [];

  GradesLoadState get loadState => _loadState;
  List<Grade> get data => _data;

  Future<void> load() async {
    if (_loadState == GradesLoadState.loading ||
        _loadState == GradesLoadState.loadingWithCache ||
        _loadState == GradesLoadState.success) {
      return;
    }

    final cached = await _repository.getCachedGrades();
    if (cached != null) {
      _loadState = GradesLoadState.loadingWithCache;
      _data = cached;
      notifyListeners();
    } else {
      _loadState = GradesLoadState.loading;
      _data = [];
      notifyListeners();
    }

    try {
      final result = await _repository.getGrades();
      _loadState = GradesLoadState.success;
      _data = result;
    } on GradesGenericException {
      if (cached != null) {
        _loadState = GradesLoadState.success;
        _data = cached;
      } else {
        _loadState = GradesLoadState.error;
        _data = [];
      }
    }

    notifyListeners();
  }

  void addGrade(Grade grade) {
    _data.add(grade);
    saveGrades();
    notifyListeners();
  }

  void removeGrade(String id) {
    final grade = _data.firstWhere((grade) => grade.id == id);
    _data.remove(grade);
    saveGrades();
    notifyListeners();
  }

  void updateGrade(Grade updatedGrade) {
    final index = _data.indexWhere((grade) => grade.id == updatedGrade.id);
    if (index != -1) {
      _data[index] = updatedGrade;
      saveGrades();
      notifyListeners();
    }
  }

  Future<void> saveGrades() async {
    await _repository.saveGrades(_data);
  }
}
