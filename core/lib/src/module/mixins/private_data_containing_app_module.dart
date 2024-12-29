import '../app_module.dart';

mixin PrivateDataContainingAppModule on AppModule {
  /// Called when the user wants to delete all private data.
  void onDeletePrivateData();
}
