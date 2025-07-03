import 'dart:async';

import 'package:shared_api/studies.dart';

import '../../../application/usecase/get_faculties_usecase.dart';

class FacultiesApiImpl implements FacultiesApi {
  FacultiesApiImpl(this._getFacultiesUsecase) {
    _getFacultiesUsecase.addListener(_onChange);
  }

  final GetFacultiesUsecase _getFacultiesUsecase;
  final StreamController<List<Faculty>> _selectedFacultiesController = StreamController<List<Faculty>>.broadcast();

  @override
  List<Faculty> get allFaculties => _getFacultiesUsecase.allFaculites;

  @override
  List<Faculty> get selectedFaculties => _getFacultiesUsecase.selectedFaculties;

  @override
  Stream<List<Faculty>> get selectedFacultiesStream => _selectedFacultiesController.stream;

  @override
  void selectFaculties(List<Faculty> faculties) {
    _getFacultiesUsecase.selectFaculties(faculties);
  }

  void _onChange() {
    _selectedFacultiesController.add(_getFacultiesUsecase.selectedFaculties);
  }

  void dispose() {
    _getFacultiesUsecase.removeListener(_onChange);
    _selectedFacultiesController.close();
  }
}
