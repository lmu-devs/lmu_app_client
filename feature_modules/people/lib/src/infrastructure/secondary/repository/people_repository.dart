import '../../../domain/interface/people_repository_interface.dart';
import '../../../domain/model/people.dart';
import '../../../domain/exception/people_generic_exception.dart';
import '../data/api/people_api_client.dart';

class PeopleRepository implements PeopleRepositoryInterface {
  const PeopleRepository(this._apiClient);

  final PeopleApiClient _apiClient;

  @override
  Future<List<People>> getPeople() async {
    try {
      final wrapper = await _apiClient.getPeople();
      return wrapper.people.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      throw const PeopleGenericException();
    }
  }
}
