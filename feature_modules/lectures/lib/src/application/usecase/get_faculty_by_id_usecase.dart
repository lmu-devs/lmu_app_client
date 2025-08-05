import 'package:shared_api/studies.dart';

import '../../domain/interface/lectures_repository_interface.dart';

class GetFacultyByIdUsecase {
  const GetFacultyByIdUsecase(this._repository);

  final LecturesRepositoryInterface _repository;

  Future<Faculty> call(int facultyId) async {
    return await _repository.getFacultyById(facultyId);
  }
}
