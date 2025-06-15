// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestPeoplePageDriver extends TestDriver implements PeoplePageDriver {
  @override
  bool get isLoading => false;

  @override
  String get allPeopleTitle => ' ';

  @override
  String get allPeopleCount => ' ';

  @override
  List<PeopleCategory> get peopleCategories => [];

  @override
  void onAllPeoplePressed() {}

  @override
  void onPeopleCardPressed(String id) {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $PeoplePageDriverProvider extends WidgetDriverProvider<PeoplePageDriver> {
  @override
  PeoplePageDriver buildDriver() {
    return PeoplePageDriver();
  }

  @override
  PeoplePageDriver buildTestDriver() {
    return _$TestPeoplePageDriver();
  }
}
