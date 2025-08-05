import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/lectures.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/lectures.dart';

import 'application/usecase/get_faculty_by_id_usecase.dart';
import 'application/usecase/get_lectures_usecase.dart';
import 'domain/interface/lectures_repository_interface.dart';
import 'infrastructure/primary/api/lectures_api.dart';
import 'infrastructure/primary/router/lectures_router.dart';
import 'infrastructure/secondary/data/api/lectures_api_client.dart';
import 'infrastructure/secondary/data/storage/lectures_storage.dart';
import 'infrastructure/secondary/repository/lectures_repository.dart';

class LecturesModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'LecturesModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final storage = LecturesStorage();
    final repository = LecturesRepository(LecturesApiClient(baseApiClient), storage);
    final getUsecase = GetLecturesUsecase(repository);
    final getFacultyByIdUsecase = GetFacultyByIdUsecase(repository);

    GetIt.I.registerSingleton<LecturesRepositoryInterface>(repository);
    GetIt.I.registerSingleton<GetLecturesUsecase>(getUsecase);
    GetIt.I.registerSingleton<GetFacultyByIdUsecase>(getFacultyByIdUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<LecturesApi>(LecturesApiImpl());
    GetIt.I.registerSingleton<LecturesRouter>(LecturesRouterImpl());
  }
}
