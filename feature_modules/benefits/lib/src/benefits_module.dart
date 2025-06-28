import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/benefits.dart';
import 'package:get_it/get_it.dart';

import 'application/usecases/delete_cached_benefits_usecase.dart';
import 'application/usecases/get_benefits_usecase.dart';
import 'domain/interface/benefits_repository_interface.dart';
import 'infrastructure/primary/routes/benefits_router.dart';
import 'infrastructure/secondary/data/api/benefits_api_client.dart';
import 'infrastructure/secondary/data/storage/benefits_storage.dart';
import 'infrastructure/secondary/repository/benefits_repository.dart';

class BenefitsModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, LocalizedDataContainigAppModule {
  @override
  String get moduleName => 'FeedbackModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final benefitsStorage = BenefitsStorage();
    final benefitsRepository = BenefitsRepository(BenefitsApiClient(baseApiClient), benefitsStorage);
    final getBenefitsUseCase = GetBenefitsUsecase(benefitsRepository);
    final deleteCachedBenefitsUsecase = DeleteCachedBenefitsUsecase(benefitsRepository);

    GetIt.I.registerSingleton<BenefitsRepositoryInterface>(benefitsRepository);
    GetIt.I.registerSingleton<GetBenefitsUsecase>(getBenefitsUseCase);
    GetIt.I.registerSingleton<DeleteCachedBenefitsUsecase>(deleteCachedBenefitsUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<BenefitsRouter>(BenefitsRouterImpl());
  }

  @override
  void onLocaleChange() {
    GetIt.I.get<DeleteCachedBenefitsUsecase>().call();
  }
}
