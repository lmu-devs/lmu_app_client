import '../../domain/interface/calendar_repository_interface.dart';
import '../../domain/model/calendar.dart';

class GetCalendarUsecase {
  const GetCalendarUsecase(this.repository);

  final CalendarRepositoryInterface repository;

  Future<Calendar?> call() => repository.getCalendar();
}
