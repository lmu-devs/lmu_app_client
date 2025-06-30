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
  PersonMock person = const PersonMock(
      id: '0',
      name: 'Max',
      surname: 'Alster',
      academicDegree: 'Prof. Dr.',
      role: 'Professor');

  @override
  String get faculty => ' ';

  @override
  String get role => ' ';

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
