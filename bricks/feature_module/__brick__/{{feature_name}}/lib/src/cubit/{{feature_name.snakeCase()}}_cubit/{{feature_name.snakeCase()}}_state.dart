import 'package:equatable/equatable.dart';

import '../../repository/api/models/{{feature_name.snakeCase()}}_model.dart';

abstract class {{feature_name.pascalCase()}}State extends Equatable{
  const {{feature_name.pascalCase()}}State();

  @override
  List<Object> get props => [];
}

class {{feature_name.pascalCase()}}Initial extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}Initial();
}

class {{feature_name.pascalCase()}}LoadInProgress extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}LoadInProgress();
}

class {{feature_name.pascalCase()}}LoadSuccess extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}LoadSuccess({required this.data});

  final {{feature_name.pascalCase()}}Model data;

  @override
  List<Object> get props => [data];
}

class {{feature_name.pascalCase()}}LoadFailure extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}LoadFailure();
}