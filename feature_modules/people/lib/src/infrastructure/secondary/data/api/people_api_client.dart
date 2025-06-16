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
            'name': 'Prof. Dr. Max Mustermann',
            'description': 'Professor für Theologie',
            'url': 'https://example.com',
            'email': 'max.mustermann@example.com',
            'phone': '+49 123 456789',
            'office': '101',
            'favicon_url': 'https://example.com/favicon.ico'
          },
          {
            'id': '2',
            'name': 'Dr. Anna Schmidt',
            'description': 'Dozentin für Theologie',
            'url': 'https://example.com',
            'email': 'anna.schmidt@example.com',
            'phone': '+49 123 456789',
            'office': '102',
            'favicon_url': 'https://example.com/favicon.ico'
          },
          {
            'id': '3',
            'name': 'Prof. Dr. Thomas Weber',
            'description': 'Professor für Jura',
            'url': 'https://example.com',
            'email': 'thomas.weber@example.com',
            'phone': '+49 123 456789',
            'office': '201',
            'favicon_url': 'https://example.com/favicon.ico'
          },
          {
            'id': '4',
            'name': 'Dr. Maria Müller',
            'description': 'Dozentin für BWL',
            'url': 'https://example.com',
            'email': 'maria.mueller@example.com',
            'phone': '+49 123 456789',
            'office': '202',
            'favicon_url': 'https://example.com/favicon.ico'
          }
        ]
      };

      return PeoplesDto.fromJson(mockData);
    }
  }
}
