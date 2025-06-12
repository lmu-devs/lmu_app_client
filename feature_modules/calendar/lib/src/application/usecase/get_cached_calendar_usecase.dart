import '../../domain/interface/calendar_repository_interface.dart';
import '../../domain/model/calendar.dart';

class GetCachedCalendarUsecase {
  const GetCachedCalendarUsecase(this.repository);

  final CalendarRepositoryInterface repository;

  Future<Calendar?> call() => repository.getCachedCalendar();
}
