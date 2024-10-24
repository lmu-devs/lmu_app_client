/// Base class for all modules.
/// Each module must implement this class and work independently from other modules.
abstract class AppModule {
  /// The name of the [AppModule], which should be unique.
  String get moduleName;
}
