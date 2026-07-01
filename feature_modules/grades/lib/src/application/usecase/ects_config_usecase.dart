import 'package:flutter/foundation.dart';

import '../../domain/interface/grades_repository_interface.dart';

/// The minimum total ECTS a user may configure.
const double minTotalEcts = 1.0;

/// The maximum total ECTS a user may configure.
const double maxTotalEcts = 300.0;

/// Parses and validates a user-provided total ECTS value.
///
/// Returns `null` if the input is not a number within [minTotalEcts]..[maxTotalEcts].
double? parseTotalEcts(String text) {
  final value = double.tryParse(text.replaceAll(',', '.'));
  if (value == null || value < minTotalEcts || value > maxTotalEcts) return null;
  return value;
}

class EctsConfigUsecase extends ChangeNotifier {
  EctsConfigUsecase(this._repository);

  final GradesRepositoryInterface _repository;

  double? _totalEcts;
  bool _isLoaded = false;

  double? get totalEcts => _totalEcts;

  bool get isLoaded => _isLoaded;

  bool get isConfigured => _totalEcts != null;

  Future<void> load() async {
    _totalEcts = await _repository.getTotalEcts();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> setTotalEcts(double totalEcts) async {
    _totalEcts = totalEcts;
    notifyListeners();
    await _repository.saveTotalEcts(totalEcts);
  }
}
