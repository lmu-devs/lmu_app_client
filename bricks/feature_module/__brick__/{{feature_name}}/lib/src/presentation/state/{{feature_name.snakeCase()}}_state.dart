import 'package:flutter/foundation.dart';

import '../../application/usecase/get_cached_{{feature_name.snakeCase()}}_usecase.dart';
import '../../application/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';
import '../../domain/model/{{feature_name.snakeCase()}}.dart';

enum {{feature_name.pascalCase()}}LoadState { initial, loading, success, error }

class {{feature_name.pascalCase()}}State {
  {{feature_name.pascalCase()}}State(this._get{{feature_name.pascalCase()}}Usecase, this._getCached{{feature_name.pascalCase()}}Usecase);

  final Get{{feature_name.pascalCase()}}Usecase _get{{feature_name.pascalCase()}}Usecase;
  final GetCached{{feature_name.pascalCase()}}Usecase _getCached{{feature_name.pascalCase()}}Usecase;

  final ValueNotifier<{{feature_name.pascalCase()}}LoadState> _stateNotifier = ValueNotifier({{feature_name.pascalCase()}}LoadState.initial);
  {{feature_name.pascalCase()}}? _{{feature_name.snakeCase()}};

  {{feature_name.pascalCase()}}? get {{feature_name.snakeCase()}} => _{{feature_name.snakeCase()}};
  ValueListenable<{{feature_name.pascalCase()}}LoadState> get loadState => _stateNotifier;

  Future<void> get{{feature_name.pascalCase()}}() async {
    if (_stateNotifier.value == {{feature_name.pascalCase()}}LoadState.loading || _stateNotifier.value == {{feature_name.pascalCase()}}LoadState.success) return;
    final cached{{feature_name.pascalCase()}} = await _getCached{{feature_name.pascalCase()}}Usecase.call();
    if (cached{{feature_name.pascalCase()}} != null) {
      _{{feature_name.snakeCase()}} = cached{{feature_name.pascalCase()}};
    }

    _stateNotifier.value = {{feature_name.pascalCase()}}LoadState.loading;

    final {{feature_name.snakeCase()}} = await _get{{feature_name.pascalCase()}}Usecase.call();
    if ({{feature_name.snakeCase()}} == null) {
      _stateNotifier.value = {{feature_name.pascalCase()}}LoadState.error;
      return;
    }
    _{{feature_name.snakeCase()}} = {{feature_name.snakeCase()}};
    _stateNotifier.value = {{feature_name.pascalCase()}}LoadState.success;
  }
}
