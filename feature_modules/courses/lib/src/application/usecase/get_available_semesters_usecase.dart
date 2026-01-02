import 'package:core/logging.dart';
import 'package:flutter/foundation.dart';

import '../../domain/exception/courses_generic_exception.dart';
import '../../domain/interface/courses_repository_interface.dart';
import '../../domain/model/available_semesters_model.dart';

enum AvailableSemestersLoadState { initial, loading, success, error }

class GetAvailableSemestersUsecase extends ChangeNotifier {
  GetAvailableSemestersUsecase(this._repository);

  final CoursesRepositoryInterface _repository;

  AvailableSemestersLoadState _loadState = AvailableSemestersLoadState.initial;
  AvailableSemestersModel? _data;

  AvailableSemestersLoadState get loadState => _loadState;
  AvailableSemestersModel? get data => _data;

  Future<void> load() async {
    if (_loadState == AvailableSemestersLoadState.loading || _loadState == AvailableSemestersLoadState.success) {
      return;
    }

    _loadState = AvailableSemestersLoadState.loading;
    _data = null;
    notifyListeners();

    try {
      final result = await _repository.getAvailableSemesters();
      _loadState = AvailableSemestersLoadState.success;
      _data = result;
    } on CoursesGenericException {
      _loadState = AvailableSemestersLoadState.error;
      _data = null;
    } catch (e) {
      _loadState = AvailableSemestersLoadState.error;
      _data = null;
    }

    notifyListeners();

    if (_loadState == AvailableSemestersLoadState.success) {
      AppLogger().logMessage(
        "[GetAvailableSemestersUsecase]: loaded availble semesters of courses.",
      );
    }
  }
}
