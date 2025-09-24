import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

import '../../domain/base/base_usecase.dart';
import '../../domain/exception/lectures_generic_exception.dart';
import '../../domain/interface/lectures_repository_interface.dart';
import '../../domain/model/lecture.dart';
import '../../domain/service/semester_config_service.dart';
import 'favorite_lectures_usecase.dart';

enum LecturesLoadState { initial, loading, loadingWithCache, success, error }

class LecturesError {
  const LecturesError({
    required this.message,
    this.details,
    this.isRetryable = true,
  });

  final String message;
  final String? details;
  final bool isRetryable;
}

class GetLecturesUsecase extends BaseUsecase {
  GetLecturesUsecase(this._repository, this._favoritesUsecase, this._semesterService) {
    // Initialize with current semester
    _termId = _defaultTermId;
    _year = _defaultYear;
  }

  final LecturesRepositoryInterface _repository;
  final FavoriteLecturesUsecase _favoritesUsecase;
  final SemesterConfigService _semesterService;

  // Flag to prevent operations after disposal
  bool _isDisposed = false;

  LecturesLoadState _loadState = LecturesLoadState.initial;
  List<Lecture> _data = [];
  LecturesError? _error;
  int? _facultyId;
  late int _termId;
  late int _year;
  bool _showOnlyFavorites = false;

  // Current semester configuration
  SemesterInfo get currentSemester => _semesterService.currentSemester;
  int get _defaultTermId => currentSemester.termId;
  int get _defaultYear => currentSemester.year;

  // ValueNotifiers for state management
  final ValueNotifier<LecturesLoadState> loadStateNotifier = ValueNotifier(LecturesLoadState.initial);
  final ValueNotifier<List<Lecture>> dataNotifier = ValueNotifier([]);
  final ValueNotifier<bool> showOnlyFavoritesNotifier = ValueNotifier(false);
  final ValueNotifier<LecturesError?> errorNotifier = ValueNotifier(null);

  LecturesLoadState get loadState => _loadState;
  List<Lecture> get data => _data;
  LecturesError? get error => _error;
  bool get showOnlyFavorites => _showOnlyFavorites;

  // Interface compatibility methods
  List<Lecture> get lectures => _data;
  bool get isLoading => _loadState == LecturesLoadState.loading;
  bool get hasError => _loadState == LecturesLoadState.error;
  String? get errorMessage => _error?.message;
  String? get errorDetails => _error?.details;
  bool get isRetryable => _error?.isRetryable ?? false;

  // Semester management
  List<SemesterInfo> get availableSemesters => _semesterService.availableSemesters;
  SemesterInfo get selectedSemester => SemesterInfo(
        termId: _termId,
        year: _year,
        displayName: _semesterService.getSemesterInfo(_termId, _year).displayName,
        isCurrent: _semesterService.getSemesterInfo(_termId, _year).isCurrent,
      );

  void changeSemester(SemesterInfo semester) {
    if (_termId == semester.termId && _year == semester.year) return;

    _termId = semester.termId;
    _year = semester.year;
    _invalidateCaches();

    // Reload data for new semester
    if (_facultyId != null) {
      load();
    }
  }

  void setFacultyId(int facultyId, {int? termId, int? year}) {
    final actualTermId = termId ?? _defaultTermId;
    final actualYear = year ?? _defaultYear;
    // Input validation
    if (facultyId <= 0) {
      // TODO: Use proper logging framework instead of debugPrint
      debugPrint('Invalid faculty ID: $facultyId');
      return;
    }
    if (actualTermId < 1 || actualTermId > 2) {
      // TODO: Use proper logging framework instead of debugPrint
      debugPrint('Invalid term ID: $actualTermId');
      return;
    }
    if (actualYear < 2000 || actualYear > 2100) {
      // TODO: Use proper logging framework instead of debugPrint
      debugPrint('Invalid year: $actualYear');
      return;
    }

    final previousFacultyId = _facultyId;
    _facultyId = facultyId;
    _termId = actualTermId;
    _year = actualYear;

    // If faculty ID changed, reset state and load new data
    if (previousFacultyId != facultyId) {
      _loadState = LecturesLoadState.initial;
      _data = [];
      _error = null;
      loadStateNotifier.value = _loadState;
      dataNotifier.value = _data;
      errorNotifier.value = _error;
      load();
    }
  }

  Future<void> load() async {
    if (_isDisposed || _facultyId == null) return;

    if (_loadState == LecturesLoadState.loading || _loadState == LecturesLoadState.loadingWithCache) {
      return;
    }

    // Try to load from cache first
    try {
      final cachedLectures = await _repository.getCachedLecturesByFaculty(_facultyId!, termId: _termId, year: _year);
      if (cachedLectures.isNotEmpty) {
        _loadState = LecturesLoadState.loadingWithCache;
        _data = cachedLectures;
        _invalidateCaches();
        loadStateNotifier.value = _loadState;
        dataNotifier.value = _data;

        // Load fresh data in background without blocking UI
        _loadFreshDataInBackground();
        return;
      } else {
        _loadState = LecturesLoadState.loading;
        _data = [];
        loadStateNotifier.value = _loadState;
        dataNotifier.value = _data;
      }
    } catch (e) {
      _loadState = LecturesLoadState.loading;
      _data = [];
      _error = null;
      loadStateNotifier.value = _loadState;
      dataNotifier.value = _data;
      errorNotifier.value = _error;
    }

    // Load from API
    await _loadFromApi();
  }

  Future<void> _loadFreshDataInBackground() async {
    if (_isDisposed) return;

    try {
      final currentFacultyId = _facultyId;
      final freshLectures = await _repository.getLecturesByFaculty(currentFacultyId!, termId: _termId, year: _year);

      // Only update if we still have the same faculty ID and not disposed
      if (!_isDisposed && _facultyId == currentFacultyId) {
        _data = freshLectures;
        _loadState = LecturesLoadState.success;
        _invalidateCaches();
        loadStateNotifier.value = _loadState;
        dataNotifier.value = _data;
      }
    } on LecturesGenericException catch (e) {
      // Log API error but keep showing cached data
      debugPrint('Background refresh failed: ${e.message}');
    } catch (e) {
      // Log unexpected error but keep showing cached data
      debugPrint('Unexpected error during background refresh: $e');
    }
  }

  Future<void> _loadFromApi() async {
    try {
      debugPrint('Loading lectures for faculty $_facultyId, term: $_termId, year: $_year');
      _data = await _repository.getLecturesByFaculty(_facultyId!, termId: _termId, year: _year);
      debugPrint('Loaded ${_data.length} lectures for faculty $_facultyId');
      _loadState = LecturesLoadState.success;
      _error = null;
    } on LecturesGenericException catch (e) {
      // If API fails and we have no cached data, show error
      if (_data.isEmpty) {
        _loadState = LecturesLoadState.error;
        _error = LecturesError(
          message: 'Failed to load lectures',
          details: e.message,
          isRetryable: true,
        );
        debugPrint('API failed with no cached data: ${e.message}');
      } else {
        // Keep cached data and show success state
        _loadState = LecturesLoadState.success;
        _error = null;
        debugPrint('API failed, showing cached data: ${e.message}');
      }
    } catch (e) {
      // Handle unexpected errors
      if (_data.isEmpty) {
        _loadState = LecturesLoadState.error;
        _error = LecturesError(
          message: 'An unexpected error occurred',
          details: e.toString(),
          isRetryable: true,
        );
        debugPrint('Unexpected error with no cached data: $e');
      } else {
        _loadState = LecturesLoadState.success;
        _error = null;
        debugPrint('Unexpected error, showing cached data: $e');
      }
    }

    loadStateNotifier.value = _loadState;
    dataNotifier.value = _data;
    errorNotifier.value = _error;
  }

  // Memoization cache for expensive operations
  List<Lecture>? _cachedFavoriteLectures;
  List<Lecture>? _cachedFilteredLectures;
  bool? _lastShowOnlyFavorites;
  Set<String>? _lastFavoriteIds;

  List<Lecture> get filteredLectures {
    final currentShowOnlyFavorites = _showOnlyFavorites;

    // Return cached result if filter state hasn't changed
    if (_cachedFilteredLectures != null && _lastShowOnlyFavorites == currentShowOnlyFavorites) {
      return _cachedFilteredLectures!;
    }

    final filtered = currentShowOnlyFavorites ? favoriteLectures : _data;

    // Cache the result
    _cachedFilteredLectures = filtered;
    _lastShowOnlyFavorites = currentShowOnlyFavorites;

    return filtered;
  }

  List<Lecture> get favoriteLectures {
    final currentFavoriteIds = _favoritesUsecase.favoriteIds;

    // Return cached result if favorites haven't changed
    if (_cachedFavoriteLectures != null &&
        _lastFavoriteIds != null &&
        _lastFavoriteIds!.length == currentFavoriteIds.length &&
        _lastFavoriteIds!.containsAll(currentFavoriteIds) &&
        currentFavoriteIds.containsAll(_lastFavoriteIds!)) {
      return _cachedFavoriteLectures!;
    }

    final favorites = _data.where((lecture) => _favoritesUsecase.isFavorite(lecture.id)).toList();

    // Cache the result
    _cachedFavoriteLectures = favorites;
    _lastFavoriteIds = Set.from(currentFavoriteIds);

    return favorites;
  }

  void toggleFavoritesFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    _invalidateCaches();
    showOnlyFavoritesNotifier.value = _showOnlyFavorites;
  }

  void toggleShowOnlyFavorites() {
    toggleFavoritesFilter();
  }

  // Invalidate all memoization caches
  void _invalidateCaches() {
    _cachedFavoriteLectures = null;
    _cachedFilteredLectures = null;
    _lastShowOnlyFavorites = null;
    _lastFavoriteIds = null;
  }

  Future<void> reload() async {
    _loadState = LecturesLoadState.initial;
    _data = [];
    _error = null;
    _invalidateCaches();
    loadStateNotifier.value = _loadState;
    dataNotifier.value = _data;
    errorNotifier.value = _error;
    await load();
  }

  // Preload data for all faculties in background
  static Future<void> preloadAllFaculties() async {
    final repository = GetIt.I.get<LecturesRepositoryInterface>();
    final faculties = GetIt.I.get<FacultiesApi>().allFaculties;

    // Preload first few faculties in parallel
    final futures = faculties.take(_preloadFacultyCount).map((faculty) async {
      try {
        await repository.getLecturesByFaculty(faculty.id);
      } catch (e) {
        // TODO: Handle preload errors gracefully
      }
    });

    await Future.wait(futures);
  }

  // Configuration constants
  static const int _preloadFacultyCount = 5;

  @override
  void addListenersToNotifiers(VoidCallback listener) {
    loadStateNotifier.addListener(listener);
    dataNotifier.addListener(listener);
    showOnlyFavoritesNotifier.addListener(listener);
    errorNotifier.addListener(listener);
  }

  @override
  void removeListenersFromNotifiers(VoidCallback listener) {
    loadStateNotifier.removeListener(listener);
    dataNotifier.removeListener(listener);
    showOnlyFavoritesNotifier.removeListener(listener);
    errorNotifier.removeListener(listener);
  }

  @override
  void disposeNotifiers() {
    loadStateNotifier.dispose();
    dataNotifier.dispose();
    showOnlyFavoritesNotifier.dispose();
    errorNotifier.dispose();
  }
}
