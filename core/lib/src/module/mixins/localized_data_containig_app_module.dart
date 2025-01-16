import '../app_module.dart';

mixin LocalizedDataContainigAppModule on AppModule {
  /// Called when the locale of the app changes.
  void onLocaleChange();
}
