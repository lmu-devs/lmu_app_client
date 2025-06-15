import '../model/{{feature_name.snakeCase()}}.dart';

abstract class {{feature_name.pascalCase()}}RepositoryInterface {
  
  /// Fetches the latest {{feature_name.pascalCase()}} data from the remote source.
  /// 
  /// Throws a [DomainException] on failure.
  Future<{{feature_name.pascalCase()}}> get{{feature_name.pascalCase()}}();
  
  /// Retrieves cached {{feature_name.pascalCase()}} data, if available.
  /// 
  /// Returns `null` if no cached data exists.
  Future<{{feature_name.pascalCase()}}?> getCached{{feature_name.pascalCase()}}();

  /// Deletes any cached {{feature_name.pascalCase()}} data.
  Future<void> delete{{feature_name.pascalCase()}}();
}
