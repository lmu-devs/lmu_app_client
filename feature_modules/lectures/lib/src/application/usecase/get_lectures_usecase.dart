import 'package:flutter/foundation.dart';

import '../../domain/exception/lectures_generic_exception.dart';
import '../../domain/interface/lectures_repository_interface.dart';
import '../../domain/model/lectures.dart';

enum LecturesLoadState { initial, loading, loadingWithCache, success, error }

class GetLecturesUsecase extends ChangeNotifier {
  GetLecturesUsecase(this._repository);

  final LecturesRepositoryInterface _repository;

  LecturesLoadState _loadState = LecturesLoadState.initial;
  Lectures? _data;

  LecturesLoadState get loadState => _loadState;
  Lectures? get data => _data;

  Future<void> load() async {
    if (_loadState == LecturesLoadState.loading ||
        _loadState == LecturesLoadState.loadingWithCache ||
        _loadState == LecturesLoadState.success) {
      return;
    }

    final cached = await _repository.getCachedLectures();
    if (cached != null) {
      _loadState = LecturesLoadState.loadingWithCache;
      _data = cached;
      notifyListeners();
    } else {
      _loadState = LecturesLoadState.loading;
      _data = null;
      notifyListeners();
    }

    try {
      final result = await _repository.getLectures();
      _loadState = LecturesLoadState.success;
      _data = result;
    } on LecturesGenericException {
      if (cached != null) {
        _loadState = LecturesLoadState.success;
        _data = cached;
      } else {
        _loadState = LecturesLoadState.error;
        _data = null;
      }
    }

    notifyListeners();
  }
}
