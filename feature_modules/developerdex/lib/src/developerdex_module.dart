import 'package:core/module.dart';
import 'package:core_routes/developerdex.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/developerdex.dart';

import 'application/usecase/get_developerdex_usecase.dart';
import 'domain/interface/developerdex_repository_interface.dart';
import 'infrastructure/primary/api/developerdex_api.dart';
import 'infrastructure/primary/router/developerdex_router.dart';
import 'infrastructure/secondary/data/storage/developerdex_storage.dart';
import 'infrastructure/secondary/repository/developerdex_repository.dart';

class DeveloperdexModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, NoticeableAppStartAppModule {
  @override
  String get moduleName => 'DeveloperdexModule';

  @override
  void provideLocalDependencies() {
    final storage = DeveloperdexStorage();
    final repository = DeveloperdexRepository(storage);
    final getDeveloperdexUsecase = GetDeveloperdexUsecase(repository);

    GetIt.I.registerSingleton<DeveloperdexRepositoryInterface>(repository);
    GetIt.I.registerSingleton<GetDeveloperdexUsecase>(getDeveloperdexUsecase);
  }

  @override
  void providePublicApi() {
    final getDeveloperdexUsecase = GetIt.I.get<GetDeveloperdexUsecase>();
    GetIt.I.registerSingleton<DeveloperdexApi>(DeveloperdexApiImpl(getDeveloperdexUsecase));
    GetIt.I.registerSingleton<DeveloperdexRouter>(DeveloperdexRouterImpl());
  }

  @override
  void onAppStartNotice() {
    final getDeveloperdexUsecase = GetIt.I.get<GetDeveloperdexUsecase>();
    getDeveloperdexUsecase.initDevelopers();
  }
}
