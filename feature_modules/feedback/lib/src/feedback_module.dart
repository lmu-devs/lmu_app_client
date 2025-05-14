import 'package:core/api.dart';
import 'package:core/core_services.dart';
import 'package:core/module.dart';
import 'application/usecases/request_app_review_usecase.dart';
import 'domain/interfaces/app_review_repository_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import 'application/usecases/open_store_listing_usecase.dart';
import 'application/usecases/send_feedback_usecase.dart';
import 'domain/interfaces/feedback_repository_interface.dart';
import 'infrastructure/primary/api/feedback_api.dart';
import 'infrastructure/secondary/data/api/feedback_api_client.dart';
import 'infrastructure/secondary/repositories/app_review_repository.dart';
import 'infrastructure/secondary/repositories/feedback_repository.dart';
import 'presentation/state/feedback_state.dart';

class FeedbackModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'FeedbackModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final systemInfo = GetIt.I.get<SystemInfoService>().systemInfo;
    final feedbackRepository = FeedbackRepository(FeedbackApiClient(baseApiClient), systemInfo);
    final feedbackState = FeedbackState();
    final appReviewRepository = AppReviewRepository();
    GetIt.I.registerSingleton<AppReviewRepositoryInterface>(appReviewRepository);
    GetIt.I.registerSingleton<FeedbackRepositoryInterface>(feedbackRepository);
    GetIt.I.registerSingleton<FeedbackState>(feedbackState);
    GetIt.I.registerSingleton<SendFeedbackUsecase>(SendFeedbackUsecase(feedbackRepository));
    GetIt.I.registerSingleton<RequestAppReviewUseCase>(RequestAppReviewUseCase(appReviewRepository));
    GetIt.I.registerSingleton<OpenStoreListingUseCase>(OpenStoreListingUseCase(appReviewRepository));
  }

  @override
  void providePublicApi() {
    final feedbackState = GetIt.I.get<FeedbackState>();
    final openStoreListingUsecase = GetIt.I.get<OpenStoreListingUseCase>();
    GetIt.I.registerSingleton<FeedbackApi>(FeedbackApiImpl(feedbackState, openStoreListingUsecase));
  }
}
