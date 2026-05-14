// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_grade_button_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestCourseGradeButtonDriver extends TestDriver
    implements CourseGradeButtonDriver {
  @override
  bool get hasGrade => false;

  @override
  String get buttonTitle => ' ';

  @override
  void onTap(BuildContext context) {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void didUpdateProvidedProperties(
      {required int newCourseId, required String newCourseName}) {}

  @override
  void dispose() {}
}

class $CourseGradeButtonDriverProvider
    extends WidgetDriverProvider<CourseGradeButtonDriver> {
  final int _courseId;
  final String _courseName;

  $CourseGradeButtonDriverProvider({
    required int courseId,
    required String courseName,
  })  : _courseId = courseId,
        _courseName = courseName;

  @override
  CourseGradeButtonDriver buildDriver() {
    return CourseGradeButtonDriver(
      courseId: _courseId,
      courseName: _courseName,
    );
  }

  @override
  CourseGradeButtonDriver buildTestDriver() {
    return _$TestCourseGradeButtonDriver();
  }

  @override
  void updateDriverProvidedProperties(CourseGradeButtonDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class CourseGradeButtonDriver extends WidgetDriver implements _$DriverProvidedProperties {
    //
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(
      newCourseId: _courseId,
      newCourseName: _courseName,
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
    required int newCourseId,
    required String newCourseName,
  });
}
