import '../app_module.dart';

mixin LocalDependenciesProvidingAppModule on AppModule {
  /// Returns the local dependencies of the module.
  void provideLocalDependencies();
}
