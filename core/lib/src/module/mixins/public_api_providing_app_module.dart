import '../app_module.dart';

mixin PublicApiProvidingAppModule on AppModule {
  /// Returns the public API of the module which can be used by other modules.
  /// This enabldes the module to expose certain functionality to other modules.
  void providePublicApi();
}
