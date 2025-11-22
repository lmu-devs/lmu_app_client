import 'package:core/logging.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/studies.dart';

import '../../domain/exception/studies_generic_exception.dart';
import '../../domain/interface/studies_repository_interface.dart';

class GetFacultiesUsecase extends ChangeNotifier {
  GetFacultiesUsecase(this._repository);

  final StudiesRepositoryInterface _repository;

  List<Faculty> _faculties = [];
  List<Faculty> _selectedFaculties = [];

  List<Faculty> get allFaculties => _faculties;
  List<Faculty> get selectedFaculties => _selectedFaculties;

  void selectFaculties(List<Faculty> faculties) {
    _selectedFaculties = faculties;
    _repository.saveSelectedFacultyIds(faculties.map((f) => f.id).toList());
  }

  Future<void> initFaculties() async {
    try {
      final faculties = await _repository.getFaculties();
      _faculties = faculties;

      final selectedFaculties = await _repository.getSelectedFacultyIds();
      _selectedFaculties = _faculties.where((faculty) => selectedFaculties.contains(faculty.id)).toList();

      notifyListeners();
    } on StudiesGenericException {
      //TODO: Error handling if api request fails and nothing cached yet
    }

    AppLogger().logMessage(
      "[GetFacultiesUsecase]: initialized with ${_faculties.length} faculties and selected faculties ${_selectedFaculties.map((f) => f.id)}.",
    );
  }
}
