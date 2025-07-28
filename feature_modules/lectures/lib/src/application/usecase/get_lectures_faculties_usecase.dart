import 'package:flutter/foundation.dart';
import 'package:shared_api/studies.dart';

class GetLecturesFacultiesUsecase extends ChangeNotifier {
  GetLecturesFacultiesUsecase(this._facultiesApi);

  final FacultiesApi _facultiesApi;

  List<Faculty> get faculties => _facultiesApi.allFaculties;

  bool get isLoading => faculties.isEmpty;

  Future<void> load() async {
    // Faculties are already loaded by the studies module
    // This method can be used for future faculty-specific loading
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
