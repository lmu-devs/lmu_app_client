import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '{{feature_name.snakeCase()}}_state.dart';
import '../../repository/{{feature_name.snakeCase()}}_repository.dart';

class {{feature_name.pascalCase()}}Cubit extends Cubit<{{feature_name.pascalCase()}}State> {
  {{feature_name.pascalCase()}}Cubit() : super(const {{feature_name.pascalCase()}}Initial());

  final _repository = GetIt.I.get<{{feature_name.pascalCase()}}Repository>();

  Future<void> load{{feature_name.pascalCase()}}() async {
    emit(const {{feature_name.pascalCase()}}LoadInProgress());
    
    try {
      final data = await _repository.get{{feature_name.pascalCase()}}();
      emit({{feature_name.pascalCase()}}LoadSuccess(data: data));
    } catch (e) {
      emit(const {{feature_name.pascalCase()}}LoadFailure());
    }
  }
}
