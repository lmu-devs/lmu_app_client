import '../../../domain/interface/{{feature_name.snakeCase()}}_repository_interface.dart';
import '../../../domain/model/{{feature_name.snakeCase()}}.dart';
import '../data/api/{{feature_name.snakeCase()}}_api_client.dart';
import '../data/storage/{{feature_name.snakeCase()}}_storage.dart';

class {{feature_name.pascalCase()}}Repository implements {{feature_name.pascalCase()}}RepositoryInterface {
  const {{feature_name.pascalCase()}}Repository(this._apiClient, this._storage);

  final {{feature_name.pascalCase()}}ApiClient _apiClient;
  final {{feature_name.pascalCase()}}Storage _storage;

  @override
  Future<{{feature_name.pascalCase()}}> get{{feature_name.pascalCase()}}() async {
    try {
      final retrived{{feature_name.snakeCase()}}Data = await _apiClient.get{{feature_name.pascalCase()}}();
      await _storage.save{{feature_name.pascalCase()}}(retrived{{feature_name.snakeCase()}}Data);
      return retrived{{feature_name.snakeCase()}}Data.toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<{{feature_name.pascalCase()}}> getCached{{feature_name.pascalCase()}}() async {
    final cached{{feature_name.pascalCase()}}Data = await _storage.get{{feature_name.pascalCase()}}();
    if (cached{{feature_name.pascalCase()}}Data == null) return null;
    try {
      return cached{{feature_name.pascalCase()}}Data.toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> delete{{feature_name.pascalCase()}}() async {
    await _storage.delete{{feature_name.pascalCase()}}();
  }
}
