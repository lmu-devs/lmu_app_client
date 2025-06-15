import 'dart:convert';

import 'package:core/api.dart';

import '../dto/peoples_dto.dart';
import 'people_api_endpoints.dart';

class PeopleApiClient {
  const PeopleApiClient(this._baseApiClient);
  final BaseApiClient _baseApiClient;

  Future<PeoplesDto> getPeople() async {
    try {
      final response = await _baseApiClient.get(PeopleApiEndpoints.people);
      final responseJson = json.decode(response.body) as Map<String, dynamic>;
      return PeoplesDto.fromJson(responseJson);
    } catch (e) {
      print('⚠️ Fallback auf Mock-Daten wegen Fehler: $e');
      // Mock data for development
      final mockData = {
        'people_types': [
          {
            'id': '1',
            'name': 'Fakultät 1',
            'description': 'Kathologisch-Theologisch',
            'emoji': '👨‍🏫',
            'people_ids': ['1', '2']
          },
          {
            'id': '2',
            'name': 'Fakultät 2',
            'description': 'Evangelisch-Theologisch',
            'emoji': '👨‍🎓',
            'people_ids': ['3', '4']
          },
          {
            'id': '3',
            'name': 'Fakultät 3',
            'description': 'Juristisch',
            'emoji': '👨‍🎓',
            'people_ids': ['3', '4']
          },
          {
            'id': '4',
            'name': 'Fakultät 4',
            'description': 'Betriebswirtschaft',
            'emoji': '👨‍🎓',
            'people_ids': ['3', '4']
          },
          {
            'id': '5',
            'name': 'Fakultät 14',
            'description': 'Mathematik, Informatik und Statistik',
            'emoji': '👨‍🎓',
            'people_ids': ['3', '4']
          }
        ],
        'peoples': [
          {
            'id': '1',
            'name': 'Prof. Dr. John Doe',
            'description': 'Computer Science',
            'url': 'https://example.com/prof1',
            'favicon_url': 'https://example.com/favicon1.png'
          },
          {
            'id': '2',
            'name': 'Prof. Dr. Jane Smith',
            'description': 'Mathematics',
            'url': 'https://example.com/prof2',
            'favicon_url': 'https://example.com/favicon2.png'
          },
          {
            'id': '3',
            'name': 'Max Student',
            'description': 'Student Council',
            'url': 'https://example.com/student1',
            'favicon_url': 'https://example.com/favicon3.png'
          },
          {
            'id': '4',
            'name': 'Anna Student',
            'description': 'Student Council',
            'url': 'https://example.com/student2',
            'favicon_url': 'https://example.com/favicon4.png'
          }
        ]
      };

      return PeoplesDto.fromJson(mockData);
    }
  }
}
