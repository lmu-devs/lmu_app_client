// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persons_details_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestPersonsDetailsPageDriver extends TestDriver
    implements PersonsDetailsPageDriver {
  @override
  List<PersonModel> persons = [_testPerson];

  @override
  String get pageTitle => ' ';

  @override
  String getFullName(PersonModel person) {
    return ' ';
  }

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void didUpdateProvidedProperties({required List<PersonModel> newPersons}) {}
}

class $PersonsDetailsPageDriverProvider
    extends WidgetDriverProvider<PersonsDetailsPageDriver> {
  final List<PersonModel> _persons;

  $PersonsDetailsPageDriverProvider({
    required List<PersonModel> persons,
  }) : _persons = persons;

  @override
  PersonsDetailsPageDriver buildDriver() {
    return PersonsDetailsPageDriver(
      persons: _persons,
    );
  }

  @override
  PersonsDetailsPageDriver buildTestDriver() {
    return _$TestPersonsDetailsPageDriver();
  }

  @override
  void updateDriverProvidedProperties(PersonsDetailsPageDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class PersonsDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
    //
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(
      newPersons: _persons,
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
    required List<PersonModel> newPersons,
  });
}
