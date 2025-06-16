// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_details_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestPeopleDetailsPageDriver extends TestDriver
    implements PeopleDetailsPageDriver {
  @override
  People person = People(
      id: 'test-id',
      name: 'Test Person',
      profileUrl: 'https://example.com',
      basicInfo:
          BasicInfo(lastName: 'Test', gender: 'male', firstName: 'Person'),
      faculty: 'Test Faculty',
      roles: [],
      courses: []);

  @override
  String get name => ' ';

  @override
  String get faculty => ' ';

  @override
  String get role => ' ';

  @override
  String get email => ' ';

  @override
  String get phone => ' ';

  @override
  String get room => ' ';

  @override
  String get website => ' ';

  @override
  String get academicDegree => ' ';

  @override
  String get employmentStatus => ' ';

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void onRoomTap(BuildContext context) {}

  @override
  void onWebsiteTap() {}

  @override
  void dispose() {}
}

class $PeopleDetailsPageDriverProvider
    extends WidgetDriverProvider<PeopleDetailsPageDriver> {
  @override
  PeopleDetailsPageDriver buildDriver() {
    return PeopleDetailsPageDriver();
  }

  @override
  PeopleDetailsPageDriver buildTestDriver() {
    return _$TestPeopleDetailsPageDriver();
  }
}
