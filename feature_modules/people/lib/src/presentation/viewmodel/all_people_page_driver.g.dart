// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_people_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestAllPeoplePageDriver extends TestDriver
    implements AllPeoplePageDriver {
  @override
  String get title => ' ';

  @override
  List<People> get peoples => [];

  @override
  bool get isLoading => false;

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}

  @override
  void onPeopleCardPressed(String personId) {}
}

class $AllPeoplePageDriverProvider
    extends WidgetDriverProvider<AllPeoplePageDriver> {
  @override
  AllPeoplePageDriver buildDriver() {
    return AllPeoplePageDriver();
  }

  @override
  AllPeoplePageDriver buildTestDriver() {
    return _$TestAllPeoplePageDriver();
  }
}
