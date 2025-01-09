import '../app_module.dart';

mixin PriorityDependenciesProvidingAppModule on AppModule {
  /// Returns the priority dependencies of the module.
  Future<void> providePriorityDependencies();
}
