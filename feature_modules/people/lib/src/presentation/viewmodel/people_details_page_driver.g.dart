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
      id: '3',
      name: 'Test Person',
      description: 'Test Description',
      email: 'test@example.com',
      phone: '123456789',
      office: 'Test Office',
      url: 'https://example.com',
      aliases: const []);

  @override
  String get name => ' ';

  @override
  String get faculty => ' ';

  @override
  String get chair => ' ';

  @override
  String get email => ' ';

  @override
  String get phone => ' ';

  @override
  String get room => ' ';

  @override
  String get website => ' ';

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void onRoomTap(BuildContext context) {}

  @override
  void onWebsiteTap() {}
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
