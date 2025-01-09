import 'package:core/module.dart';
import 'package:feedback/src/repository/api/api.dart';
import 'package:feedback/src/repository/feedback_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import 'services/default_feedback_service.dart';

class FeedbackModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'FeedbackModule';

  @override
  void provideLocalDependencies() {
    final repository = ConnectedFeedbackRepository(feedbackApiClient: FeedbackApiClient());

    GetIt.I.registerSingleton<FeedbackRepository>(repository);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<FeedbackService>(DefaultFeedbackService());
  }
}
