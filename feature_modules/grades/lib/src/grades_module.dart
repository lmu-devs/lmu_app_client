import 'package:core/module.dart';
import 'package:core_routes/grades.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/grades.dart';

import 'application/usecase/ects_config_usecase.dart';
import 'application/usecase/get_grades_usecase.dart';
import 'application/usecase/grades_toast_service.dart';
import 'domain/interface/grades_repository_interface.dart';
import 'infrastructure/primary/api/grades_api.dart';
import 'infrastructure/primary/router/grades_router.dart';
import 'infrastructure/secondary/data/storage/grades_storage.dart';
import 'infrastructure/secondary/repository/grades_repository.dart';

class GradesModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'GradesModule';

  @override
  void provideLocalDependencies() {
    final storage = GradesStorage();
    final repository = GradesRepository(storage);
    final getUsecase = GetGradesUsecase(repository);
    final ectsConfigUsecase = EctsConfigUsecase(repository);
    final toastService = GradesToastService();

    GetIt.I.registerSingleton<GradesRepositoryInterface>(repository);
    GetIt.I.registerSingleton<GetGradesUsecase>(getUsecase);
    GetIt.I.registerSingleton<EctsConfigUsecase>(ectsConfigUsecase);
    GetIt.I.registerSingleton<GradesToastService>(toastService);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<GradesApi>(GradesApiImpl());
    GetIt.I.registerSingleton<GradesRouter>(GradesRouterImpl());
  }
}
