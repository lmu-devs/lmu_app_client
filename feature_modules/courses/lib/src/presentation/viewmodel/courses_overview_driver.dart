import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/courses.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_available_semesters_usecase.dart';
import '../../application/usecase/get_courses_usecase.dart';
import '../../application/usecase/favorite_courses_usecase.dart';
import '../../domain/model/available_semesters_model.dart';
import '../../domain/model/course_model.dart';
import '../../domain/model/semester_model.dart';

part 'courses_overview_driver.g.dart';

@GenerateTestDriver()
class CoursesOverviewDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  CoursesOverviewDriver({
    @driverProvidableProperty required int facultyId,
  }) : _facultyId = facultyId;

  late int _facultyId;

  int get facultyId => _facultyId;

  final _semesterUsecase = GetIt.I.get<GetAvailableSemestersUsecase>();
  final _coursesUsecase = GetIt.I.get<GetCoursesUsecase>();
  final _favoritesUsecase = GetIt.I.get<FavoriteCoursesUsecase>();
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  late LmuLocalizations _localizations;
  late LmuToast _toast;

  String get showAllFacultiesText => _localizations.studies.showAllFaculties;

  List<Faculty> get selectedFaculties => _facultiesApi.selectedFaculties;

  List<Faculty> get allFaculties => _facultiesApi.allFaculties;

  late final ValueNotifier<SemesterModel?> selectedSemesterNotifier = ValueNotifier(null);
  AvailableSemestersModel? get availableSemesters => _semesterUsecase.data;
  SemesterModel? get selectedSemester => selectedSemesterNotifier.value;

  String currentSemesterText(SemesterModel semester) {
    String semesterType = semester.semesterType;
    int year = semester.year;

    if (semesterType == "WINTER") {
      semesterType = _localizations.home.winter;
    } else if (semesterType == "SUMMER") {
      semesterType = _localizations.home.summer;
    }

    return "$semesterType $year";
  }

  bool get isLoading => _coursesUsecase.loadState != CoursesLoadState.success;

  String get pageTitle => _localizations.courses.coursesTitle;

  String get largeTitle {
    final faculty = allFaculties.firstWhere((f) => f.id == facultyId);
    return _localizations.studies.facultiesSubtitle(faculty.name);
  }

  late Set<String> _selectedDegrees = {};
  late Set<String> _selectedTypes = {};
  late Set<String> _selectedLanguages = {};
  late Set<int> _selectedSws = {};

  Set<String> get selectedDegrees => _selectedDegrees;

  Set<String> get selectedTypes => _selectedTypes;

  Set<String> get selectedLanguages => _selectedLanguages;

  Set<int> get selectedSws => _selectedSws;

  List<String> get availableDegrees =>
      _extractUniqueStrings((course) => course.degree)
          .where((degree) => degree != "-")
          .toList();

  List<String> get availableTypes =>
      _extractUniqueStrings((course) => course.type)
          .where((type) => type != "n/a")
          .toList();

  List<String> get availableLanguages =>
      _extractUniqueStrings((course) => course.language);

  List<int> get availableSws {
    final swsList = _coursesUsecase.data
        .map((c) => c.sws)
        .where((s) => s != null)
        .cast<int>()
        .toSet()
        .toList();
    swsList.sort();
    return swsList;
  }

  List<String> _extractUniqueStrings(String? Function(CourseModel) selector) {
    final list = _coursesUsecase.data
        .map(selector)
        .where((string) => string != null && string.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
    list.sort();
    return list;
  }

  bool get isFilterActive =>
      _selectedDegrees.isNotEmpty ||
      _selectedTypes.isNotEmpty ||
      _selectedLanguages.isNotEmpty ||
      _selectedSws.isNotEmpty;

  List<CourseModel> get courses {
    final rawData = _coursesUsecase.data;

    if (!isFilterActive) {
      return rawData;
    }

    return rawData.where((course) {
      if (_selectedDegrees.isNotEmpty) {
        if (course.degree == null ||
            !_selectedDegrees.contains(course.degree)) {
          return false;
        }
      }

      if (_selectedTypes.isNotEmpty) {
        if (!_selectedTypes.contains(course.type)) {
          return false;
        }
      }

      if (_selectedLanguages.isNotEmpty) {
        if (!_selectedLanguages.contains(course.language)) {
          return false;
        }
      }

      if (_selectedSws.isNotEmpty) {
        if (course.sws == null || !_selectedSws.contains(course.sws)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void applyFilters({
    required Set<String> degrees,
    required Set<String> types,
    required Set<String> languages,
    required Set<int> sws,
  }) {
    _selectedDegrees = Set.from(degrees);
    _selectedTypes = Set.from(types);
    _selectedLanguages = Set.from(languages);
    _selectedSws = Set.from(sws);
    notifyWidget();
  }

  bool isFavorite(int id) => _favoritesUsecase.isFavorite(id);

  Future<void> toggleFavorite(BuildContext context, int id) async {
    await _favoritesUsecase.toggleFavorite(facultyId, id);

    if (context.mounted) {
      if (!isFavorite(id)) {
        LmuToast.show(
          context: context,
          type: ToastType.success,
          message: context.locals.app.favoriteRemoved,
          actionText: context.locals.app.undo,
          onActionPressed: () => _favoritesUsecase.toggleFavorite(facultyId, id),
        );
      } else {
        LmuToast.show(
          context: context,
          type: ToastType.success,
          message: context.locals.app.favoriteAdded,
        );
      }
    }
  }

  Future<void> updateFavoriteCoursesOrder(List<int> favoriteIds) async {
    await _favoritesUsecase.updateFavoriteCoursesOrder(_facultyId, favoriteIds);
  }

  List<CourseModel> get nonFavoriteCourses => courses
      .where((course) => !_favoritesUsecase.isFavorite(course.publishId))
      .toList();

  Map<String, List<CourseModel>> get groupedCourses {
    final grouped = <String, List<CourseModel>>{};

    for (final course in courses) {
      final firstLetter =
          course.name.isNotEmpty ? course.name[0].toUpperCase() : '#';
      if (!grouped.containsKey(firstLetter)) {
        grouped[firstLetter] = [];
      }
      grouped[firstLetter]!.add(course);
    }

    final sortedKeys = grouped.keys.toList()..sort();
    final sortedGrouped = <String, List<CourseModel>>{};
    for (final key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }

    return sortedGrouped;
  }

  void onCoursePressed(BuildContext context, CourseModel course) {
    CourseDetailsRoute(
      facultyId: facultyId,
      courseId: course.publishId,
      name: course.name,
      language: course.language,
      degree: course.degree,
      sws: course.sws,
    ).push(context);
  }

  void onShowAllFacultiesPressed(BuildContext context) {
    const CoursesFacultyOverviewRoute().push(context);
  }

  void onSearchPressed(BuildContext context) {
    CoursesSearchRoute(facultyId: facultyId).push(context);
  }

  void selectSemester(SemesterModel semester) {
    selectedSemesterNotifier.value = semester;
    _reloadCourses(semester.semesterType, semester.year);
  }

  void _reloadCourses(String semesterType, int year) {
    _coursesUsecase.load(_facultyId, semesterType, year);
    notifyWidget();
  }

  void _onStateChanged() {
    if (selectedSemester == null &&
        _semesterUsecase.data != null) {
      selectedSemesterNotifier.value = _semesterUsecase.data!.currentSemester;
    }

    notifyWidget();

    if (_coursesUsecase.loadState == CoursesLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _localizations.app.somethingWentWrong,
      type: ToastType.error,
      actionText: _localizations.app.tryAgain,
      onActionPressed: () => _coursesUsecase.load(_facultyId),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _coursesUsecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _coursesUsecase.load(_facultyId);
    });
    _facultiesApi.selectedFacultiesStream.listen((_) => notifyWidget());
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
    selectedSemesterNotifier.dispose();
    _coursesUsecase.removeListener(_onStateChanged);
    _favoritesUsecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
