import '../../domain/exception/calendar_generic_exception.dart';
import '../../domain/interface/calendar_repository_interface.dart';
import '../../domain/model/calendar_entry.dart';

class CreateCalendarEntryUsecase {
  CreateCalendarEntryUsecase(this._repository);

  final CalendarRepositoryInterface _repository;

  Future<void> execute(CalendarEntry entry) async {
    try {
      await _repository.createCalendarEntry(entry);
    } catch (e) {
      throw CalendarGenericException(e.toString());
    }
  }
}
