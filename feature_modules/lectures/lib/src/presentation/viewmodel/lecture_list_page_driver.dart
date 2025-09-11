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
  bool get hasData => _usecase.loadState == LecturesLoadState.success && _usecase.data.isNotEmpty;

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
  }

  // Actions
  void onLectureCardPressed(BuildContext context, String lectureId, String lectureTitle) {
    LectureDetailRoute(
      lectureId: lectureId,
      lectureTitle: lectureTitle,
    ).go(context);
  }

  void onLectureFavoriteToggle(String lectureId) {
    _favoritesUsecase.toggleFavorite(lectureId);
  }

  void onFavoritesFilterToggle() {
    _usecase.toggleFavoritesFilter();
  }

  void onMyStudyPressed() {
    // TODO: implement My Study functionality
  }

  void onSortPressed() {
    // TODO: implement sort functionality
  }

  void retry() {
    _usecase.load();
  }
}
