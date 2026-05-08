import 'package:core/api.dart';
import 'package:core/core_services.dart';
import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import 'domain/interfaces/app_review_repository_interface.dart';
import 'domain/interfaces/feedback_repository_interface.dart';
import 'infrastructure/primary/api/feedback_api.dart';
import 'infrastructure/secondary/data/api/feedback_api_client.dart';
import 'infrastructure/secondary/repositories/app_review_repository.dart';
import 'infrastructure/secondary/repositories/feedback_repository.dart';

class FeedbackModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'FeedbackModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final systemInfo = GetIt.I.get<SystemInfoService>().systemInfo;
    final feedbackRepository = FeedbackRepository(FeedbackApiClient(baseApiClient), systemInfo);
    final appReviewRepository = AppReviewRepository();
    GetIt.I.registerSingleton<AppReviewRepositoryInterface>(appReviewRepository);
    GetIt.I.registerSingleton<FeedbackRepositoryInterface>(feedbackRepository);
  }

  @override
  void providePublicApi() {
    final appReviewRepository = GetIt.I.get<AppReviewRepositoryInterface>();
    GetIt.I.registerSingleton<FeedbackApi>(FeedbackApiImpl(appReviewRepository));
  }
}
