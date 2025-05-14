import '../model/{{feature_name.snakeCase()}}dart pub global activate mason_cli.dart';

abstract class {{feature_name.pascalCase()}}RepositoryInterface {
  Future<{{feature_name.pascalCase()}}?> get{{feature_name.pascalCase()}}();
  
  Future<{{feature_name.pascalCase()}}?> getCached{{feature_name.pascalCase()}}();

  Future<void> delete{{feature_name.pascalCase()}}();
}
