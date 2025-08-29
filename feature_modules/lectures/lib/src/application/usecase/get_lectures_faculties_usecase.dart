import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

enum LectureByFacultiesLoadState { initial, loading, success, error }

class GetLectureByFacultiesUsecase extends ChangeNotifier {
  GetLectureByFacultiesUsecase();

  FacultiesApi get _facultiesApi => GetIt.I.get<FacultiesApi>();

  LectureByFacultiesLoadState _loadState = LectureByFacultiesLoadState.initial;
  List<Faculty> _faculties = [];

  LectureByFacultiesLoadState get loadState => _loadState;
  List<Faculty> get faculties => _faculties;
  bool get isLoading => _loadState == LectureByFacultiesLoadState.loading;
  bool get hasError => _loadState == LectureByFacultiesLoadState.error;

  Future<void> load() async {
    if (_loadState == LectureByFacultiesLoadState.loading || _loadState == LectureByFacultiesLoadState.success) {
      return;
    }

    _loadState = LectureByFacultiesLoadState.loading;
    notifyListeners();

    try {
      // Faculties are already loaded by the studies module
      _faculties = _facultiesApi.allFaculties;
      _loadState = LectureByFacultiesLoadState.success;
    } catch (e) {
      _loadState = LectureByFacultiesLoadState.error;
      _faculties = [];
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
