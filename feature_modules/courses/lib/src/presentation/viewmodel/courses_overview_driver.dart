import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/courses.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_courses_usecase.dart';
import '../../application/usecase/favorite_courses_usecase.dart';
import '../../domain/model/course_model.dart';

part 'courses_overview_driver.g.dart';

@GenerateTestDriver()
class CoursesOverviewDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  CoursesOverviewDriver({
    @driverProvidableProperty required int facultyId,
  }) : _facultyId = facultyId;

  late int _facultyId;

  int get facultyId => _facultyId;

  final _usecase = GetIt.I.get<GetCoursesUsecase>();
  final _favoritesUsecase = GetIt.I.get<FavoriteCoursesUsecase>();
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  late LmuLocalizations _localizations;
  late LmuToast _toast;

  String get showAllFacultiesText => _localizations.studies.showAllFaculties;

  List<Faculty> get selectedFaculties => _facultiesApi.selectedFaculties;

  List<Faculty> get allFaculties => _facultiesApi.allFaculties;

  bool get isLoading => _usecase.loadState != CoursesLoadState.success;

  String get pageTitle => _localizations.courses.coursesTitle;

  String get largeTitle {
    final faculty = allFaculties.firstWhere((f) => f.id == facultyId);
    return _localizations.studies.facultiesSubtitle(faculty.name);
  }

  Future<void> toggleFavorite(int id) async {
    await _favoritesUsecase.toggleFavorite(id);
  }

  bool isFavorite(int id) => _favoritesUsecase.isFavorite(id);

  List<CourseModel> get courses => _usecase.data;

  List<CourseModel> get favoriteCourses => courses
      .where((course) => _favoritesUsecase.isFavorite(course.publishId))
      .toList();

  List<CourseModel> get nonFavoriteCourses => courses
      .where((course) => !_favoritesUsecase.isFavorite(course.publishId))
      .toList();

  bool get hasFavorites => _favoritesUsecase.favoriteIds.isNotEmpty;

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

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == CoursesLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _localizations.app.somethingWentWrong,
      type: ToastType.error,
      actionText: _localizations.app.tryAgain,
      onActionPressed: () => _usecase.load(_facultyId),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _usecase.load(_facultyId);
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
    _usecase.removeListener(_onStateChanged);
    _favoritesUsecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
