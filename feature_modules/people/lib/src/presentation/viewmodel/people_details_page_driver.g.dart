// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_details_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestPeopleDetailsPageDriver extends TestDriver implements PeopleDetailsPageDriver {
  @override
  int get personId => 0;

  @override
  String get loadingText => ' ';

  @override
  String get personNotFoundText => ' ';

  @override
  String get contactText => ' ';

  @override
  String get emailText => ' ';

  @override
  String get phoneText => ' ';

  @override
  String get websiteText => ' ';

  @override
  String get roomText => ' ';

  @override
  String get consultationHoursText => ' ';

  @override
  String get copiedEmailText => ' ';

  @override
  String get copiedPhoneText => ' ';

  @override
  String get copiedWebsiteText => ' ';

  @override
  String get addedToFavoritesText => ' ';

  @override
  String get removedFromFavoritesText => ' ';

  @override
  People? get person => null;

  @override
  bool get isLoading => false;

  @override
  bool get isFavorite => false;

  @override
  String get faculty => ' ';

  @override
  String get role => ' ';

  @override
  String get title => ' ';

  @override
  String get email => ' ';

  @override
  String get phone => ' ';

  @override
  String get website => ' ';

  @override
  String get room => ' ';

  @override
  String get consultation => ' ';

  @override
  String get facultyAndRole => ' ';

  @override
  Future<void> onEmailTap(BuildContext context) {
    return Future.value();
  }

  @override
  Future<void> onPhoneTap(BuildContext context) {
    return Future.value();
  }

  @override
  Future<void> onWebsiteTap(BuildContext context) {
    return Future.value();
  }

  @override
  Future<void> onRoomTap() {
    return Future.value();
  }

  @override
  Future<void> onConsultationTap() {
    return Future.value();
  }

  @override
  Future<void> onFavoriteTap(BuildContext context) {
    return Future.value();
  }

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void didUpdateProvidedProperties({required int newPersonId}) {}

  @override
  void dispose() {}
}

class $PeopleDetailsPageDriverProvider extends WidgetDriverProvider<PeopleDetailsPageDriver> {
  final int _personId;

  $PeopleDetailsPageDriverProvider({
    required int personId,
  }) : _personId = personId;

  @override
  PeopleDetailsPageDriver buildDriver() {
    return PeopleDetailsPageDriver(
      personId: _personId,
    );
  }

  @override
  PeopleDetailsPageDriver buildTestDriver() {
    return _$TestPeopleDetailsPageDriver();
  }

  @override
  void updateDriverProvidedProperties(PeopleDetailsPageDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class PeopleDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
    //
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(
      newPersonId: _personId,
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
    required int newPersonId,
  });
}
