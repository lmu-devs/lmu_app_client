import 'package:flutter/foundation.dart';
import 'package:shared_api/studies.dart' hide Faculty;

import '../../../application/usecase/favorite_lectures_usecase.dart';
import '../../../application/usecase/get_lectures_usecase.dart';
import '../../../domain/interface/lectures_driver_dependencies.dart';
import '../../../domain/model/lecture.dart';
import '../../../domain/service/semester_config_service.dart';

/// Adapter to make GetLecturesUsecase implement LecturesUsecaseInterface
class GetLecturesUsecaseAdapter implements LecturesUsecaseInterface {
  const GetLecturesUsecaseAdapter(this._usecase);

  final GetLecturesUsecase _usecase;

  @override
  List<Lecture> get lectures => _usecase.lectures;

  @override
  bool get isLoading => _usecase.isLoading;

  @override
  bool get hasError => _usecase.hasError;

  @override
  String? get errorMessage => _usecase.error?.message;

  @override
  String? get errorDetails => _usecase.error?.details;

  @override
  bool get isRetryable => _usecase.error?.isRetryable ?? false;

  @override
  bool get showOnlyFavorites => _usecase.showOnlyFavorites;

  @override
  Future<void> load() => _usecase.load();

  @override
  Future<void> reload() => _usecase.reload();

  @override
  void toggleShowOnlyFavorites() => _usecase.toggleShowOnlyFavorites();

  // Semester management
  List<SemesterInfo> get availableSemesters => _usecase.availableSemesters;
  SemesterInfo get selectedSemester => _usecase.selectedSemester;
  void changeSemester(SemesterInfo semester) => _usecase.changeSemester(semester);

  @override
  void addListener(VoidCallback listener) => _usecase.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _usecase.removeListener(listener);

  @override
  void dispose() => _usecase.dispose();
}

/// Adapter to make FavoriteLecturesUsecase implement FavoritesUsecaseInterface
class FavoriteLecturesUsecaseAdapter implements FavoritesUsecaseInterface {
  const FavoriteLecturesUsecaseAdapter(this._usecase);

  final FavoriteLecturesUsecase _usecase;

  @override
  Set<String> get favoriteIds => _usecase.favoriteIds;

  @override
  bool isFavorite(String lectureId) => _usecase.isFavorite(lectureId);

  @override
  void toggleFavorite(String lectureId) => _usecase.toggleFavorite(lectureId);

  @override
  void addFavorite(String lectureId) => _usecase.addFavorite(lectureId);

  @override
  void removeFavorite(String lectureId) => _usecase.removeFavorite(lectureId);

  @override
  void addListener(VoidCallback listener) => _usecase.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _usecase.removeListener(listener);

  @override
  void dispose() => _usecase.dispose();
}

/// Adapter to make FacultiesApi implement FacultiesApiInterface
class FacultiesApiAdapter implements FacultiesApiInterface {
  const FacultiesApiAdapter(this._api);

  final FacultiesApi _api;

  @override
  List<Faculty> get allFaculties => _api.allFaculties.map((faculty) => Faculty(faculty.id, faculty.name)).toList();

  @override
  Faculty? getFacultyById(int id) {
    try {
      final faculty = _api.allFaculties.firstWhere((f) => f.id == id);
      return Faculty(faculty.id, faculty.name);
    } catch (e) {
      return null;
    }
  }
}
