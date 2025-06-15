import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/calendar.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/calendar.dart';

import 'application/usecase/get_calendar_usecase.dart';
import 'domain/interface/calendar_repository_interface.dart';
import 'infrastructure/primary/api/calendar_api.dart';
import 'infrastructure/primary/router/calendar_router.dart';
import 'infrastructure/secondary/data/api/calendar_api_client.dart';
import 'infrastructure/secondary/data/storage/calendar_storage.dart';
import 'infrastructure/secondary/repository/calendar_repository.dart';

class CalendarModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'CalendarModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final calendarStorage = CalendarStorage();
    final calendarRepository = CalendarRepository(CalendarApiClient(baseApiClient), calendarStorage);
    final getCalendarUseCase = GetCalendarUsecase(calendarRepository);

    GetIt.I.registerSingleton<CalendarRepositoryInterface>(calendarRepository);
    GetIt.I.registerSingleton<GetCalendarUsecase>(getCalendarUseCase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<CalendarApi>(CalendarApiImpl());
    GetIt.I.registerSingleton<CalendarRouter>(CalendarRouterImpl());
  }
}
