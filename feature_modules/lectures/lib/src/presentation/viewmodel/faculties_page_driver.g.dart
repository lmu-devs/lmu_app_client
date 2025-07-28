// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculties_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestFacultiesPageDriver extends TestDriver
    implements FacultiesPageDriver {
  @override
  List<Faculty> get faculties => [];

  @override
  bool get isLoading => false;

  @override
  String getCourseCount(Faculty faculty) {
    return ' ';
  }

  @override
  void onFacultyPressed(BuildContext context, Faculty faculty) {}

  @override
  void didUpdateBuildContext(BuildContext context) {}
}

class $FacultiesPageDriverProvider
    extends WidgetDriverProvider<FacultiesPageDriver> {
  @override
  FacultiesPageDriver buildDriver() {
    return FacultiesPageDriver();
  }

  @override
  FacultiesPageDriver buildTestDriver() {
    return _$TestFacultiesPageDriver();
  }
}
