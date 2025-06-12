import 'package:core/api.dart';

import '../dto/calendar_dto.dart';

class CalendarApiClient {
  const CalendarApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<CalendarDto> getCalendar() async {
    return const CalendarDto(id: 'test-id-123', name: 'TestCalendarEintrag');
    // final response = await _baseApiClient.get(CalendarApiEndpoints.calendar);
    // return CalendarDto.fromJson(jsonDecode(response.body));
  }
}
