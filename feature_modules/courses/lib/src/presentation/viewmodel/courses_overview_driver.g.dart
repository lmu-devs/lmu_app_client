// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_overview_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestCoursesOverviewDriver extends TestDriver
    implements CoursesOverviewDriver {
  @override
  int get facultyId => 0;

  @override
  String get showAllFacultiesText => ' ';

  @override
  List<Faculty> get selectedFaculties => [];

  @override
  List<Faculty> get allFaculties => [];

  @override
  bool get isLoading => false;

  @override
  String get pageTitle => ' ';

  @override
  String get largeTitle => ' ';

  @override
  Set<String> get selectedDegrees => {};

  @override
  Set<String> get selectedTypes => {};

  @override
  Set<String> get selectedLanguages => {};

  @override
  Set<int> get selectedSws => {};

  @override
  List<String> get availableDegrees => [];

  @override
  List<String> get availableTypes => [];

  @override
  List<String> get availableLanguages => [];

  @override
  List<int> get availableSws => [];

  @override
  bool get isFilterActive => false;

  @override
  List<CourseModel> get courses => [];

  @override
  List<CourseModel> get nonFavoriteCourses => [];

  @override
  Map<String, List<CourseModel>> get groupedCourses => {};

  @override
  void applyFilters(
      {required Set<String> degrees,
      required Set<String> types,
      required Set<String> languages,
      required Set<int> sws}) {}

  @override
  bool isFavorite(int id) {
    return false;
  }

  @override
  Future<void> toggleFavorite(BuildContext context, int id) {
    return Future.value();
  }

  @override
  void onCoursePressed(BuildContext context, CourseModel course) {}

  @override
  void onShowAllFacultiesPressed(BuildContext context) {}

  @override
  void onSearchPressed(BuildContext context) {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void didUpdateProvidedProperties({required int newFacultyId}) {}

  @override
  void dispose() {}
}

class $CoursesOverviewDriverProvider
    extends WidgetDriverProvider<CoursesOverviewDriver> {
  final int _facultyId;

  $CoursesOverviewDriverProvider({
    required int facultyId,
  }) : _facultyId = facultyId;

  @override
  CoursesOverviewDriver buildDriver() {
    return CoursesOverviewDriver(
      facultyId: _facultyId,
    );
  }

  @override
  CoursesOverviewDriver buildTestDriver() {
    return _$TestCoursesOverviewDriver();
  }

  @override
  void updateDriverProvidedProperties(CoursesOverviewDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class CoursesOverviewDriver extends WidgetDriver implements _$DriverProvidedProperties {
    //
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(
      newFacultyId: _facultyId,
    );
  }
}

// ignore: one_member_abstracts
abstract class _$DriverProvidedProperties {
  /// This function allows you to react to changes of the `driverProvidableProperties` in the driver.
  ///
  /// These properties are coming to the driver from the widget, and in Flutter, the widgets get recreated often.
  /// But the driver does not get recreated for each widget creation. The drivers lifecycle is similar to that of a state.
  /// That means that your driver constructor is not called when a new widget is created.
  /// So the driver constructor does not get a chance to read any potential changes of the properties in the widget.
  ///
  /// Important, you do not need to call `notifyWidget()` in this method.
  /// This method is called right before the build method of the DrivableWidget.
  /// Thus all data changed here will be shown with the "currently ongoing render cycle".
  ///
  /// Very Important!!
  /// Because this function is running during the build process,
  /// it is NOT the place to run time consuming or blocking tasks etc. (like calling Api-Endpoints)
  /// This could greatly impact your apps performance.
  void didUpdateProvidedProperties({
    required int newFacultyId,
  });
}
