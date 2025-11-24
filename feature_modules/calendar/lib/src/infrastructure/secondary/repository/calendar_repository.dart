import '../../../domain/exception/calendar_generic_exception.dart';
import '../../../domain/interface/calendar_repository_interface.dart';
import '../../../domain/model/calendar.dart';
import '../../../domain/model/calendar_entry.dart';
import '../data/api/calendar_api_client.dart';
import '../data/dto/calendar_entry_mapper.dart';
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
      throw CalendarGenericException(e.toString());
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
  Future<List<CalendarEntry>> getCalendarEvents() async {
    try {
      final fetchedEventDtos = await _apiClient.getCalendarEntries();
      final List<CalendarEntry> fetchedEventData =
          fetchedEventDtos.map((dto) => CalendarEntryMapper.fromDto(dto)).toList();
      return fetchedEventData;
    } on FormatException catch (e) {
      throw CalendarGenericException('Format error: ${e.message}');
    } catch (e) {
      throw CalendarGenericException(e.toString());
    }
  }

  @override
  Future<List<CalendarEntry>?> getCachedCalendarEntries() async {
    final cachedCalendarEntriesData = await _storage.getCalendarEntries();
    if (cachedCalendarEntriesData == null) return null;
    try {
      return cachedCalendarEntriesData.map((dto) => CalendarEntryMapper.fromDto(dto)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createCalendarEntry(CalendarEntry entry) async {
    print("Creating calendar entry: $entry");
    try {
      final dto = CalendarEntryMapper.toDto(entry);

      try {
        print("DTO to be sent to API: $dto");
        await _apiClient.createCalendarEntry(dto);
      } catch (e) {
        print("Error with DTO: $e");
      }
      await _storage.deleteCalendarEntries();
    } catch (e) {
      throw CalendarGenericException(' 😡 Failed to create entry: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteCalendar() async {
    await _storage.deleteCalendar();
  }
}
