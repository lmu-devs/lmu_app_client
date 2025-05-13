import '../../domain/interface/{{feature_name.snakeCase()}}_repository_interface.dart';
import '../../domain/model/{{feature_name.snakeCase()}}.dart';

class GetCached{{feature_name.pascalCase()}}Usecase {
  const GetCached{{feature_name.pascalCase()}}Usecase(this.repository);

  final {{feature_name.pascalCase()}}RepositoryInterface repository;

  Future<{{feature_name.pascalCase()}}?> call() => repository.getCached{{feature_name.pascalCase()}}();
}
