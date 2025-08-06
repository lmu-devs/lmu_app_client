import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/lectures.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_lectures_usecase.dart';
import '../../application/usecase/get_lectures_usecase.dart';
import '../../domain/model/lecture.dart';

part 'lecture_list_page_driver.g.dart';

@GenerateTestDriver()
class LectureListPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  LectureListPageDriver({
    @driverProvidableProperty required int facultyId,
  }) : _facultyId = facultyId;

  late int _facultyId;
  int get facultyId => _facultyId;

  final _usecase = GetIt.I.get<GetLecturesUsecase>();
  final _favoritesUsecase = GetIt.I.get<FavoriteLecturesUsecase>();
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  LmuLocalizations? _localizations;
  LmuToast? _toast;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);

    // Set faculty ID and load data
    _usecase.setFacultyId(_facultyId);
    if (_usecase.data.isEmpty) {
      _usecase.load();
    }
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
    _toast = LmuToast.of(context);
  }

  @override
  void didUpdateProvidedProperties({
    required int newFacultyId,
  }) {
    _facultyId = newFacultyId;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    _favoritesUsecase.removeListener(_onStateChanged);
    super.dispose();
  }

  // Faculty information
  String get facultyName {
    final faculty = _facultiesApi.allFaculties.firstWhere((f) => f.id == _facultyId);
    return faculty.name;
  }

  // State management
  bool get isLoading => _usecase.loadState == LecturesLoadState.loading;
  bool get hasError => _usecase.loadState == LecturesLoadState.error;
  bool get hasData => _usecase.data.isNotEmpty;

  // Data
  List<Lecture> get lectures => _usecase.filteredLectures;
  List<Lecture> get favoriteLectures => _usecase.favoriteLectures;
  List<Lecture> get nonFavoriteLectures => _usecase.nonFavoriteLectures;

  // Filtered data for display
  List<Lecture> get filteredLectures {
    if (_usecase.showOnlyFavorites) {
      return favoriteLectures;
    }
    return lectures;
  }

  bool get isFavoritesFilterActive => _usecase.showOnlyFavorites;

  int get lectureCount => filteredLectures.length;

  // Grouped lectures for display
  Map<String, List<Lecture>> get groupedLectures {
    final grouped = <String, List<Lecture>>{};

    for (final lecture in filteredLectures) {
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

    return sortedGrouped;
  }

  // State change handling
  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == LecturesLoadState.error) {
      _showErrorToast();
    }
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
    _showToast(_favoritesUsecase.isFavorite(lectureId)
        ? _localizations?.lectures.addFavorite ?? 'Added to favorites'
        : _localizations?.lectures.removeFavorite ?? 'Removed from favorites');
  }

  void onFavoritesFilterToggle() {
    _usecase.toggleFavoritesFilter();
  }

  void onMyStudyPressed() {
    _showToast('My Study functionality coming soon');
  }

  void onSortPressed() {
    _showToast('Sort functionality coming soon');
  }

  void retry() {
    _usecase.load();
  }

  // Toast helpers
  void _showToast(String message) {
    _toast?.showToast(
      message: message,
      type: ToastType.base,
    );
  }

  void _showErrorToast() {
    _toast?.showToast(
      message: _localizations?.app.somethingWentWrong ?? 'Something went wrong',
      type: ToastType.error,
      actionText: _localizations?.app.tryAgain ?? 'Try again',
      onActionPressed: () => _usecase.load(),
    );
  }
}
