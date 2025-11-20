// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestCourseDetailsPageDriver extends TestDriver
    implements CourseDetailsPageDriver {
  @override
  int get courseId => 0;

  @override
  CourseDetailsModel? get courseDetails => null;

  @override
  bool get isLoading => false;

  @override
  bool get isFavorite => false;

  @override
  Future<void> toggleFavorite(int id) {
    return Future.value();
  }

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void didUpdateProvidedProperties({required int newCourseId}) {}

  @override
  void dispose() {}
}

class $CourseDetailsPageDriverProvider
    extends WidgetDriverProvider<CourseDetailsPageDriver> {
  final int _courseId;

  $CourseDetailsPageDriverProvider({
    required int courseId,
  }) : _courseId = courseId;

  @override
  CourseDetailsPageDriver buildDriver() {
    return CourseDetailsPageDriver(
      courseId: _courseId,
    );
  }

  @override
  CourseDetailsPageDriver buildTestDriver() {
    return _$TestCourseDetailsPageDriver();
  }

  @override
  void updateDriverProvidedProperties(CourseDetailsPageDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class CourseDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
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
  });
}
