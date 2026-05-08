// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestClubsPageDriver extends TestDriver implements ClubsPageDriver {
  @override
  bool get isLoading => false;

  @override
  bool get isGenericError => false;

  @override
  bool get isNoNetworkError => false;

  @override
  String get allClubsTitle => ' ';

  @override
  String get allClubsCount => ' ';

  @override
  List<ClubCategory> get clubCategories => [];

  @override
  void onAllClubsPressed() {}

  @override
  void onClubCategoryPressed(ClubCategory clubCategory) {}

  @override
  void onRetry() {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $ClubsPageDriverProvider extends WidgetDriverProvider<ClubsPageDriver> {
  @override
  ClubsPageDriver buildDriver() {
    return ClubsPageDriver();
  }

  @override
  ClubsPageDriver buildTestDriver() {
    return _$TestClubsPageDriver();
  }
}
