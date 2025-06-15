import '../../../domain/exception/calendar_generic_exception.dart';
import '../../../domain/interface/calendar_repository_interface.dart';
import '../../../domain/model/calendar.dart';
import '../data/api/calendar_api_client.dart';
import '../data/storage/calendar_storage.dart';

class CalendarRepository implements CalendarRepositoryInterface {
  const CalendarRepository(this._apiClient, this._storage);

  final CalendarApiClient _apiClient;
  final CalendarStorage _storage;

  @override
  Future<Calendar> getCalendar() async {
    try {
      final retrivedCalendarData = await _apiClient.getCalendar();
      await _storage.saveCalendar(retrivedCalendarData);
      return retrivedCalendarData.toDomain();
    } catch (e) {
      throw const CalendarGenericException();
    }
  }

  @override
  Future<Calendar?> getCachedCalendar() async {
    final cachedCalendarData = await _storage.getCalendar();
    if (cachedCalendarData == null) return null;
    try {
      return cachedCalendarData.toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteCalendar() async {
    await _storage.deleteCalendar();
  }
}
