import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/studies.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

import 'application/usecase/get_faculties_usecase.dart';
import 'domain/interface/studies_repository_interface.dart';
import 'infrastructure/primary/api/faculties_api.dart';
import 'infrastructure/primary/router/studies_router.dart';
import 'infrastructure/secondary/data/api/studies_api_client.dart';
import 'infrastructure/secondary/data/storage/studies_storage.dart';
import 'infrastructure/secondary/repository/studies_repository.dart';

class StudiesModule extends AppModule
    with PublicApiProvidingAppModule, WaitingAppStartAppModule, LocalDependenciesProvidingAppModule {
  @override
  String get moduleName => 'StudiesModule';

  @override
  Future onAppStartWaiting() {
    return GetIt.I.get<GetFacultiesUsecase>().initFaculites();
  }

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final studiesStorage = StudiesStorage();
    final studiesRepository = StudiesRepository(StudiesApiClient(baseApiClient), studiesStorage);
    final getFacultiesUsecase = GetFacultiesUsecase(studiesRepository);

    GetIt.I.registerSingleton<StudiesRepositoryInterface>(studiesRepository);
    GetIt.I.registerSingleton<GetFacultiesUsecase>(getFacultiesUsecase);
  }

  @override
  void providePublicApi() {
    final getFacultiesUsecase = GetIt.I.get<GetFacultiesUsecase>();
    GetIt.I.registerSingleton<FacultiesApi>(FacultiesApiImpl(getFacultiesUsecase));
    GetIt.I.registerSingleton<StudiesRouter>(StudiesRouterImpl());
  }
}
