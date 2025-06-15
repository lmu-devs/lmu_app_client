import 'package:flutter/foundation.dart';

import '../../domain/exception/{{feature_name.snakeCase()}}_generic_exception.dart';
import '../../domain/interface/{{feature_name.snakeCase()}}_repository_interface.dart';
import '../../domain/model/{{feature_name.snakeCase()}}.dart';

enum {{feature_name.pascalCase()}}LoadState { initial, loading, loadingWithCache, success, error }

class Get{{feature_name.pascalCase()}}Usecase extends ChangeNotifier {
  Get{{feature_name.pascalCase()}}Usecase(this._repository);

  final {{feature_name.pascalCase()}}RepositoryInterface _repository;

  {{feature_name.pascalCase()}}LoadState _loadState = {{feature_name.pascalCase()}}LoadState.initial;
  {{feature_name.pascalCase()}}? _data;

  {{feature_name.pascalCase()}}LoadState get loadState => _loadState;
  {{feature_name.pascalCase()}}? get data => _data;

  Future<void> load() async {
    if (_loadState == {{feature_name.pascalCase()}}LoadState.loading ||
        _loadState == {{feature_name.pascalCase()}}LoadState.loadingWithCache ||
        _loadState == {{feature_name.pascalCase()}}LoadState.success) {
      return;
    }

    final cached = await _repository.getCached{{feature_name.pascalCase()}}();
    if (cached != null) {
      _loadState = {{feature_name.pascalCase()}}LoadState.loadingWithCache;
      _data = cached;
      notifyListeners();
    } else {
      _loadState = {{feature_name.pascalCase()}}LoadState.loading;
      _data = null;
      notifyListeners();
    }

    try {
      final result = await _repository.get{{feature_name.pascalCase()}}();
      _loadState = {{feature_name.pascalCase()}}LoadState.success;
      _data = result;
    } on {{feature_name.pascalCase()}}GenericException {
      if (cached != null) {
        _loadState = {{feature_name.pascalCase()}}LoadState.success;
        _data = cached;
      } else {
        _loadState = {{feature_name.pascalCase()}}LoadState.error;
        _data = null;
      }
    }

    notifyListeners();
  }
}
