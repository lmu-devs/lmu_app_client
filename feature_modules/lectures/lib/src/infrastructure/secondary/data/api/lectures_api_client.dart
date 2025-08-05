import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

import '../dto/lectures_dto.dart';
import 'lectures_api_endpoints.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<LecturesDto> getLectures() async {
    return const LecturesDto(id: "1234234", name: "Natural Computing");
    // ignore: dead_code
    final response = await _baseApiClient.get(LecturesApiEndpoints.lectures);
    return LecturesDto.fromJson(jsonDecode(response.body));
  }

  Future<Faculty> getFacultyById(int facultyId) async {
    // Use the shared FacultiesApi to get consistent data
    final facultiesApi = GetIt.I.get<FacultiesApi>();
    final faculty = facultiesApi.allFaculties.firstWhere(
      (faculty) => faculty.id == facultyId,
      orElse: () => throw Exception('Faculty not found'),
    );

    return faculty;

    // ignore: dead_code
    // final response = await _baseApiClient.get('${LecturesApiEndpoints.faculty}/$facultyId');
    // return FacultyDto.fromJson(jsonDecode(response.body));
  }
}
