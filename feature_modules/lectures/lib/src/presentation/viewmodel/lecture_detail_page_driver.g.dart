// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_detail_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestLectureDetailPageDriver extends TestDriver
    implements LectureDetailPageDriver {
  @override
  String get lectureId => ' ';

  @override
  String get lectureTitle => ' ';

  @override
  bool get isLoading => false;

  @override
  bool get hasError => false;

  @override
  bool get isNotFound => false;

  @override
  Lecture? get lecture => null;

  @override
  String get displayLectureTitle => ' ';

  @override
  bool get isFavorite => false;

  @override
  String get loadingText => ' ';

  @override
  String get lectureNotFoundText => ' ';

  @override
  String get errorText => ' ';

  @override
  String get retryText => ' ';

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void didUpdateProvidedProperties(
      {required String newLectureId, required String newLectureTitle}) {}

  @override
  void dispose() {}

  @override
  void onRetry() {}

  @override
  void onFavoriteToggle() {}
}

class $LectureDetailPageDriverProvider
    extends WidgetDriverProvider<LectureDetailPageDriver> {
  final String _lectureId;
  final String _lectureTitle;

  $LectureDetailPageDriverProvider({
    required String lectureId,
    required String lectureTitle,
  })  : _lectureId = lectureId,
        _lectureTitle = lectureTitle;

  @override
  LectureDetailPageDriver buildDriver() {
    return LectureDetailPageDriver(
      lectureId: _lectureId,
      lectureTitle: _lectureTitle,
    );
  }

  @override
  LectureDetailPageDriver buildTestDriver() {
    return _$TestLectureDetailPageDriver();
  }

  @override
  void updateDriverProvidedProperties(LectureDetailPageDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class LectureDetailPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
    //
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(
      newLectureId: _lectureId,
      newLectureTitle: _lectureTitle,
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
    required String newLectureId,
    required String newLectureTitle,
  });
}
