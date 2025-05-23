import 'package:flutter/foundation.dart';

import '../usecase/get_cached_{{feature_name.snakeCase()}}_usecase.dart';
import '../usecase/get_{{feature_name.snakeCase()}}_usecase.dart';
import '../../domain/model/{{feature_name.snakeCase()}}.dart';

enum {{feature_name.pascalCase()}}LoadState { initial, loading, loadingWithCache, success, error }

typedef {{feature_name.pascalCase()}}State = ({ {{feature_name.pascalCase()}}LoadState loadState, {{feature_name.pascalCase()}}? {{feature_name.snakeCase()}} });

class {{feature_name.pascalCase()}}StateService {
  {{feature_name.pascalCase()}}StateService(this._get{{feature_name.pascalCase()}}Usecase, this._getCached{{feature_name.pascalCase()}}Usecase);

  final Get{{feature_name.pascalCase()}}Usecase _get{{feature_name.pascalCase()}}Usecase;
  final GetCached{{feature_name.pascalCase()}}Usecase _getCached{{feature_name.pascalCase()}}Usecase;

  final ValueNotifier<{{feature_name.pascalCase()}}State> _stateNotifier = ValueNotifier<{{feature_name.pascalCase()}}State>(
    (loadState: {{feature_name.pascalCase()}}LoadState.initial, {{feature_name.snakeCase()}}: null),
  );

  ValueListenable<{{feature_name.pascalCase()}}State> get stateNotifier => _stateNotifier;

  Future<void> get{{feature_name.pascalCase()}}() async {
    final currentState = _stateNotifier.value.loadState;
    if (currentState == {{feature_name.pascalCase()}}LoadState.loading || currentState == {{feature_name.pascalCase()}}LoadState.success) return;

    final cached{{feature_name.pascalCase()}} = await _getCached{{feature_name.pascalCase()}}Usecase.call();
    if (cached{{feature_name.pascalCase()}} != null) {
      _stateNotifier.value = (loadState: {{feature_name.pascalCase()}}LoadState.loadingWithCache, {{feature_name.snakeCase()}}: cached{{feature_name.pascalCase()}});
    } else {
      _stateNotifier.value = (loadState: {{feature_name.pascalCase()}}LoadState.loading, {{feature_name.snakeCase()}}: null);
    }

    final {{feature_name.snakeCase()}} = await _get{{feature_name.pascalCase()}}Usecase.call();
    if ({{feature_name.snakeCase()}} != null) {
      _stateNotifier.value = (loadState: {{feature_name.pascalCase()}}LoadState.success, {{feature_name.snakeCase()}}: {{feature_name.snakeCase()}});
      return;
    }
    _stateNotifier.value = (loadState: {{feature_name.pascalCase()}}LoadState.error, {{feature_name.snakeCase()}}: null);
  }
}
