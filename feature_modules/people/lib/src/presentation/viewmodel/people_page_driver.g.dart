// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.3"

class _$TestPeoplePageDriver extends TestDriver implements PeoplePageDriver {
  @override
  List<bool> favoriteStates = [];

  @override
  bool get isLoading => false;

  @override
  String get largeTitle => ' ';

  @override
  String get peopleId => ' ';

  @override
  String get title => ' ';

  @override
  String get description => ' ';

  @override
  void toggleFavorite(int index) {}

  @override
  void onPeopleCardPressed(BuildContext context, String id, String title, String description) {}

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
