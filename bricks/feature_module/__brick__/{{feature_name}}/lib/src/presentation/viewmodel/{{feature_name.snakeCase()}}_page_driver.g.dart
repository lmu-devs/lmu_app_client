// GENERATED CODE - DO NOT MODIFY BY HAND

part of '{{feature_name.snakeCase()}}_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.3"

class _$Test{{feature_name.pascalCase()}}PageDriver extends TestDriver implements {{feature_name.pascalCase()}}PageDriver {
  @override
  bool get isLoading => false;

  @override
  String get largeTitle => ' ';

  @override
  String get {{feature_name.snakeCase()}}Id => ' ';

  @override
  String get title => ' ';

  @override
  String get description => ' ';

  @override
  void on{{feature_name.pascalCase()}}CardPressed() {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class ${{feature_name.pascalCase()}}PageDriverProvider extends WidgetDriverProvider<{{feature_name.pascalCase()}}PageDriver> {
  @override
  {{feature_name.pascalCase()}}PageDriver buildDriver() {
    return {{feature_name.pascalCase()}}PageDriver();
  }

  @override
  {{feature_name.pascalCase()}}PageDriver buildTestDriver() {
    return _$Test{{feature_name.pascalCase()}}PageDriver();
  }
}
