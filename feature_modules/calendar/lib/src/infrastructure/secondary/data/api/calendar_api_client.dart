import 'dart:convert';

import 'package:core/api.dart';
import 'package:core/logging.dart';

import '../../../../domain/model/mock_events.dart';
import '../dto/calendar_dto.dart';
import '../dto/calendar_entry_dto.dart';
import 'calendar_api_endpoints.dart';

final _appLogger = AppLogger();

class CalendarApiClient {
  const CalendarApiClient(this._baseApiClient);
  final BaseApiClient _baseApiClient;

  /// Creates a new calendar entry.
  Future<CalendarEntryDto> createCalendarEntry(CalendarEntryDto calendarData) async {
    final response = await _baseApiClient.post(
      CalendarApiEndpoints.createCalendarEntry(),
      body: jsonEncode(calendarData.toJson()),
      additionalHeaders: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create calendar entry - ${response.statusCode}: ${response.body}');
    }

    final jsonList = json.decode(response.body) as List<dynamic>;
    return CalendarEntryDto.fromJson({'entries': jsonList});
  }

  /// Deletes a calendar entry by its ID.
  Future<bool> deleteCalendarEntry(String entryId) async {
    final response = await _baseApiClient.delete(
      CalendarApiEndpoints.deleteCalendarEntry(),
      additionalHeaders: {'entry_id': entryId}, // UUID is passed as query parameter in DELETE
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete calendar entry - ${response.statusCode}');
    }

    return response.body == 'true';
  }

  /// Updates an existing calendar entry.
  /// TODO: Endpoint changed, so the method needs to be updated accordingly.
  Future<CalendarEntryDto> updateCalendarEntry({
    required CalendarEntryDto calendarData,
    required String entryId,
    int? recurrenceId,
    int updateType = 0,
  }) async {
    // TODO: Update return vallue to match the API
    return createMockCalendarEntryDtos().first;
  }

  /// Retrieves calendar entries for a user, with optional filters.
  Future<List<CalendarEntryDto>> getCalendarEntries({
    String? eventType,
    String? frequency,
    bool? allDay,
  }) async {
    final url = CalendarApiEndpoints.getCalendarEntries(
      eventType: eventType,
      frequency: frequency,
      allDay: allDay,
    );

    _appLogger.logMessage("[DEBUG] Request URL: $url");

    final response = await _baseApiClient.get(url);

    _appLogger.logMessage("[DEBUG] Raw API Response Body (Status ${response.statusCode}): ${response.body}");

    if (response.statusCode == 504) {
      throw Exception('Failed to load calendar data - Gateway Timeout (504)');
    } else if (response.statusCode >= 400) {
      final errorBody = json.decode(response.body);
      String errorMessage = 'Failed to load calendar data - Status: ${response.statusCode}';
      if (errorBody is Map && errorBody.containsKey('detail')) {
        errorMessage += ', Detail: ${errorBody['detail']}';
      } else {
        errorMessage += ', Body: ${response.body}';
      }
      throw Exception(errorMessage);
    }

    if (response.body.isEmpty) {
      throw Exception('calendar API response body is empty.');
    }

    // try {
    //   final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    //   return jsonList.map((json) => CalendarEntryDto.fromJson(json)).toList();
    // } on TypeError catch (e) {
    //   _appLogger.logMessage("Error during calendar JSON decoding/casting: $e");
    //   throw Exception(
    //       'Unexpected calendar API response format. Expected a list but got a map or other type. Error: $e');
    // } on FormatException catch (e) {
    //   _appLogger.logMessage("Error parsing JSON calendarresponse: $e");
    //   throw Exception('Invalid JSON response from API. Error: $e');
    // }
    try {
      final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;

      // NEUER, DETAILLIERTER LOGGING-BLOCK
      return jsonList.map((jsonItem) {
        try {
          // Versuchen, jedes einzelne JSON-Element zu konvertieren
          return CalendarEntryDto.fromJson(jsonItem as Map<String, dynamic>);
        } catch (e) {
          // Protokolliere das spezifische JSON-Objekt, das den Fehler verursacht hat.
          // Das hilft Ihnen, das fehlende/null-Feld zu identifizieren.
          _appLogger.logMessage("🛑 [DECODING ERROR] Failed to parse item: $jsonItem. Error: $e");
          // Da der Fehler unvorhergesehen ist, werfen wir ihn erneut,
          // um den Aufruf-Stack zu erhalten.
          rethrow;
        }
      }).toList();
      // ENDE NEUER BLOCK
    } on TypeError catch (e) {
      _appLogger.logMessage("Error during calendar JSON decoding/casting: $e");
      throw Exception(
          'Unexpected calendar API response format. Expected a list but got a map or other type. Error: $e');
    } on FormatException catch (e) {
      _appLogger.logMessage("Error parsing JSON calendarresponse: $e");
      throw Exception('Invalid JSON response from API. Error: $e');
    }
  }

  // TODO: delete
  Future<CalendarDto> getCalendar() async {
    return const CalendarDto(id: 'test-id-123', name: 'TestCalendarEintrag');
    // final response = await _baseApiClient.get(CalendarApiEndpoints.calendar);
    // return CalendarDto.fromJson(jsonDecode(response.body));
  }
}
