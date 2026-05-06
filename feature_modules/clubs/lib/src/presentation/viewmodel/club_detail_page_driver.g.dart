// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_detail_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestClubDetailPageDriver extends TestDriver implements ClubDetailPageDriver {
  @override
  Club get club => Club(
      id: '',
      universityId: '',
      type: ClubType.fachschaft,
      title: '',
      description: '',
      category: ClubCategoryType.academic);

  @override
  void didUpdateProvidedProperties({required Club newClub}) {}
}

class $ClubDetailPageDriverProvider extends WidgetDriverProvider<ClubDetailPageDriver> {
  final Club _club;

  $ClubDetailPageDriverProvider({
    required Club club,
  }) : _club = club;

  @override
  ClubDetailPageDriver buildDriver() {
    return ClubDetailPageDriver(
      club: _club,
    );
  }

  @override
  ClubDetailPageDriver buildTestDriver() {
    return _$TestClubDetailPageDriver();
  }

  @override
  void updateDriverProvidedProperties(ClubDetailPageDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class ClubDetailPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
    //
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(
      newClub: _club,
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
    required Club newClub,
  });
}
