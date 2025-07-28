import 'package:flutter/foundation.dart';
import 'package:shared_api/studies.dart';

enum LecturesLoadState { initial, loading, success, error }

class GetLecturesFacultiesUsecase extends ChangeNotifier {
  GetLecturesFacultiesUsecase(this._facultiesApi);

  final FacultiesApi _facultiesApi;

  LecturesLoadState _loadState = LecturesLoadState.initial;
  List<Faculty> _faculties = [];

  LecturesLoadState get loadState => _loadState;
  List<Faculty> get faculties => _faculties;
  bool get isLoading => _loadState == LecturesLoadState.loading;
  bool get hasError => _loadState == LecturesLoadState.error;

  Future<void> load() async {
    if (_loadState == LecturesLoadState.loading || _loadState == LecturesLoadState.success) {
      return;
    }

    _loadState = LecturesLoadState.loading;
    _faculties = [];
    notifyListeners();

    try {
      // Faculties are already loaded by the studies module
      _faculties = _facultiesApi.allFaculties;
      _loadState = LecturesLoadState.success;
    } catch (e) {
      _loadState = LecturesLoadState.error;
      _faculties = [];
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
