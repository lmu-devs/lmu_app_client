import 'package:core_routes/lectures.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/interface/lectures_driver_dependencies.dart';
import '../../domain/model/lecture.dart';
import '../../domain/service/semester_config_service.dart';
import '../../infrastructure/primary/factory/lectures_driver_factory.dart';

part 'lecture_list_page_driver.g.dart';

@GenerateTestDriver()
class LectureListPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  LectureListPageDriver({
    @driverProvidableProperty required int facultyId,
    required LecturesUsecaseInterface lecturesUsecase,
    required FavoritesUsecaseInterface favoritesUsecase,
    required FacultiesApiInterface facultiesApi,
  })  : _facultyId = facultyId,
        _lecturesUsecase = lecturesUsecase,
        _favoritesUsecase = favoritesUsecase,
        _facultiesApi = facultiesApi;

  late int _facultyId;
  int get facultyId => _facultyId;

  final LecturesUsecaseInterface _lecturesUsecase;
  final FavoritesUsecaseInterface _favoritesUsecase;
  final FacultiesApiInterface _facultiesApi;

  // Public getter for the favorites usecase
  @TestDriverDefaultValue(null)
  FavoritesUsecaseInterface? get favoritesUsecase => _favoritesUsecase;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _lecturesUsecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);

    // Load data for the faculty
    _lecturesUsecase.load();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
  }

  @override
  void didUpdateProvidedProperties({
    required int newFacultyId,
  }) {
    if (_facultyId != newFacultyId) {
      _facultyId = newFacultyId;
      _lecturesUsecase.load();
    }
  }

  @override
  void dispose() {
    _lecturesUsecase.removeListener(_onStateChanged);
    _favoritesUsecase.removeListener(_onStateChanged);
    super.dispose();
  }

  /// Gets the faculty name for the current faculty ID
  /// Returns 'Invalid Faculty' for invalid IDs or 'Unknown Faculty' if not found
  String get facultyName {
    // Validate faculty ID before lookup
    if (_facultyId <= 0) {
      return 'Invalid Faculty'; // TODO: Use localization key
    }

    try {
      final faculty = _facultiesApi.getFacultyById(_facultyId);
      return faculty?.name ?? 'Unknown Faculty'; // TODO: Use localization key
    } catch (e) {
      return 'Unknown Faculty'; // TODO: Use localization key
    }
  }

  // State management
  bool get isLoading => _lecturesUsecase.isLoading;
  bool get hasError => _lecturesUsecase.hasError;
  bool get hasData => !_lecturesUsecase.isLoading && !_lecturesUsecase.hasError && _lecturesUsecase.lectures.isNotEmpty;
  String? get errorMessage => _lecturesUsecase.errorMessage;
  String? get errorDetails => _lecturesUsecase.errorDetails;
  bool get isRetryable => _lecturesUsecase.isRetryable;

  // Data
  List<Lecture> get lectures => _lecturesUsecase.lectures;
  bool get showOnlyFavorites => _lecturesUsecase.showOnlyFavorites;

  // Semester management
  @TestDriverDefaultValue([])
  List<SemesterInfo> get availableSemesters => _lecturesUsecase.availableSemesters;

  @TestDriverDefaultValue(SemesterInfo(termId: 1, year: 2025, displayName: 'Winter 24/25', isCurrent: true))
  SemesterInfo get selectedSemester => _lecturesUsecase.selectedSemester;

  void changeSemester(SemesterInfo semester) => _lecturesUsecase.changeSemester(semester);

  // Memoization cache for expensive operations
  Map<String, List<Lecture>>? _cachedGroupedLectures;
  List<Lecture>? _cachedFavoriteLectures;
  List<Lecture>? _cachedFilteredLectures;
  bool? _lastShowOnlyFavorites;
  int? _lastLectureCount;
  int? _lastDataHash;

  /// Gets the list of favorite lectures with memoization for performance
  List<Lecture> get favoriteLectures {
    final currentLectures = _lecturesUsecase.lectures;
    final currentShowOnlyFavorites = _lecturesUsecase.showOnlyFavorites;

    // Return cached result if data hasn't changed
    if (_cachedFavoriteLectures != null && _lastShowOnlyFavorites == currentShowOnlyFavorites) {
      return _cachedFavoriteLectures!;
    }

    final favorites = currentLectures.where((lecture) => _favoritesUsecase.isFavorite(lecture.id)).toList();

    // Cache the result
    _cachedFavoriteLectures = favorites;
    _lastShowOnlyFavorites = currentShowOnlyFavorites;

    return favorites;
  }

  /// Gets the filtered lectures based on favorites filter with memoization
  List<Lecture> get filteredLectures {
    final currentShowOnlyFavorites = _lecturesUsecase.showOnlyFavorites;

    // Return cached result if filter state hasn't changed
    if (_cachedFilteredLectures != null && _lastShowOnlyFavorites == currentShowOnlyFavorites) {
      return _cachedFilteredLectures!;
    }

    final filtered = currentShowOnlyFavorites ? favoriteLectures : _lecturesUsecase.lectures;

    // Cache the result
    _cachedFilteredLectures = filtered;

    return filtered;
  }

  // Memoized lecture count
  int get lectureCount {
    final currentFiltered = filteredLectures;

    // Return cached result if data hasn't changed
    if (_lastLectureCount != null && _lastLectureCount == currentFiltered.length) {
      return _lastLectureCount!;
    }

    final count = currentFiltered.length;

    // Cache the result
    _lastLectureCount = count;

    return count;
  }

  /// Gets lectures grouped by first letter for display with optimized memoization
  /// Uses hash-based comparison for O(1) performance instead of O(n) list comparison
  Map<String, List<Lecture>> get groupedLectures {
    final currentFilteredLectures = filteredLectures;
    final currentHash = _calculateDataHash(currentFilteredLectures);

    // Return cached result if data hasn't changed (using hash for O(1) comparison)
    if (_cachedGroupedLectures != null && _lastDataHash == currentHash) {
      return _cachedGroupedLectures!;
    }

    final grouped = <String, List<Lecture>>{};

    for (final lecture in currentFilteredLectures) {
      final firstLetter = lecture.title.isNotEmpty ? lecture.title[0].toUpperCase() : '#';
      if (!grouped.containsKey(firstLetter)) {
        grouped[firstLetter] = [];
      }
      grouped[firstLetter]!.add(lecture);
    }

    final sortedKeys = grouped.keys.toList()..sort();
    final sortedGrouped = <String, List<Lecture>>{};
    for (final key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }

    // Cache the result
    _cachedGroupedLectures = sortedGrouped;
    _lastDataHash = currentHash;

    return sortedGrouped;
  }

  // Helper method to calculate hash for efficient comparison
  int _calculateDataHash(List<Lecture> lectures) {
    int hash = 0;
    for (final lecture in lectures) {
      hash = hash ^ lecture.id.hashCode;
    }
    return hash;
  }

  // State change handling
  void _onStateChanged() {
    // Invalidate caches when state changes
    _invalidateCaches();
    notifyWidget();
  }

  // Invalidate all memoization caches
  void _invalidateCaches() {
    _cachedGroupedLectures = null;
    _cachedFavoriteLectures = null;
    _cachedFilteredLectures = null;
    _lastShowOnlyFavorites = null;
    _lastLectureCount = null;
    _lastDataHash = null;
  }

  // Actions
  void onLectureCardPressed(BuildContext context, String lectureId, String lectureTitle) {
    LectureDetailRoute(
      lectureId: lectureId,
      lectureTitle: lectureTitle,
    ).push(context);
  }

  void onLectureFavoriteToggle(String lectureId) {
    _favoritesUsecase.toggleFavorite(lectureId);
  }

  void onFavoritesFilterToggle() {
    _lecturesUsecase.toggleShowOnlyFavorites();
  }

  void onMyStudyPressed() {
    // TODO: implement My Study functionality - navigate to user's study plan
    // This would typically open a study plan or curriculum view
  }

  void onSortPressed() {
    // TODO: implement sort functionality - show sort options (by name, SWS, etc.)
    // This would typically show a bottom sheet with sorting options
  }

  void retry() {
    _lecturesUsecase.reload();
  }
}
