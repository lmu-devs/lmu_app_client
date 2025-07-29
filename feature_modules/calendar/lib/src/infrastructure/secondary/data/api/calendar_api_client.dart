import 'dart:convert';

import 'package:core/api.dart';
import 'package:core/logging.dart';

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
      throw Exception('Failed to create calendar entry - ${response.statusCode}');
    }

    final jsonList = json.decode(response.body) as List<dynamic>;
    return CalendarEntryDto.fromJson(
        {'entries': jsonList}); // Assuming CalendarEntriesModel expects a list under 'entries'
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
  Future<CalendarEntryDto> updateCalendarEntry({
    required CalendarEntryDto calendarData,
    required String entryId,
    int? recurrenceId,
    int updateType = 0,
  }) async {
    final queryParams = <String, dynamic>{
      'entry_id': entryId,
      'update_type': updateType.toString(),
    };
    if (recurrenceId != null) {
      queryParams['recurrence_id'] = recurrenceId.toString();
    }

    final Map<String, String> additionalHeaders = {
      'Content-Type': 'application/json',
    };

    queryParams.forEach((key, value) {
      additionalHeaders[key] = value;
    });

    final response = await _baseApiClient.put(
      CalendarApiEndpoints.updateCalendarEntry(),
      body: jsonEncode(calendarData.toJson()),
      additionalHeaders: additionalHeaders,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update calendar entry - ${response.statusCode}');
    }

    final jsonList = json.decode(response.body) as List<dynamic>;
    return CalendarEntryDto.fromJson({'entries': jsonList});
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

    _appLogger.logMessage("[DEBUG] Request URL: $url"); // Log the exact URL being called

    // return createMockCalendarEntryDtos();

    final response = await _baseApiClient.get(url);

    _appLogger.logMessage("[DEBUG] Raw API Response Body (Status ${response.statusCode}): ${response.body}");

    if (response.statusCode == 504) {
      throw Exception('Failed to load calendar data - Gateway Timeout (504)');
    } else if (response.statusCode >= 400) {
      // Handle other client/server errors (e.g., 404, 400, 500)
      final errorBody = json.decode(response.body);
      String errorMessage = 'Failed to load calendar data - Status: ${response.statusCode}';
      if (errorBody is Map && errorBody.containsKey('detail')) {
        errorMessage += ', Detail: ${errorBody['detail']}';
      } else {
        errorMessage += ', Body: ${response.body}';
      }
      throw Exception(errorMessage);
    }

    // Check if the response body is empty or not a valid JSON structure before decoding
    if (response.body.isEmpty) {
      throw Exception('calendar API response body is empty.');
    }

    // Attempt to decode as a List<dynamic>
    try {
      final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
      // Map each item in the list to a CalendarEntryDto object
      return jsonList.map((json) => CalendarEntryDto.fromJson(json)).toList();
    } on TypeError catch (e) {
      // This catches the '_Map<String, dynamic>' is not a subtype of type 'List<dynamic>' error
      _appLogger.logMessage("Error during calendar JSON decoding/casting: $e");
      _appLogger.logMessage("Response calendar body was: ${response.body}");
      throw Exception(
          'Unexpected calendar API response format. Expected a list but got a map or other type. Error: $e');
    } on FormatException catch (e) {
      // This catches errors if the response body is not valid JSON
      _appLogger.logMessage("Error parsing JSON calendarresponse: $e");
      _appLogger.logMessage("Response calendar body was: ${response.body}");
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
